//Get inputs
getControls();

//Restart Game
if restartKey game_restart();

#region Glide Mechanic
if !onGround && glideKey && !airAttackStart && !isGrabbing && !beingHitted{
	if !glideStart{
		//if yspd < 0 yspd=0;
		termVel = glideTermVel;
		glideStart = true;
	}
}else{
	termVel = defaultTermVel;	
	glideStart = false;
}
#endregion

#region Get out of solid moveplats that have positioned themselves into the player in the begin step
var _rightWall = noone;
var _leftWall = noone;
var _bottomWall = noone;
var _topWall = noone;
var _list = ds_list_create();
var _listSize = instance_place_list(x,y,oMovePlat,_list, false);

//Loop through all colliding move plats
for(var i=0 ; i<_listSize ; i++){
	var _listInst = _list[|i];
	
	//Find closest walls in each direction
	//Right Walls
	//If there are walls to the right of me, get the closest one
	if _listInst.bbox_left - _listInst.xspd >= bbox_right-1{
		if !instance_exists(_rightWall) || _listInst.bbox_left < _rightWall.bbox_left{
			_rightWall = _listInst;
		}
	}
	//Left Walls
	//If there are walls to the left of me, get the closest one
	if(_listInst.bbox_right - _listInst.xspd<=bbox_left+1){
		if !instance_exists(_leftWall) || _listInst.bbox_right > _leftWall.bbox_right{
			_leftWall = _listInst;
		}
	}
	//Bottom Wall
	if _listInst.bbox_top - _listInst.yspd>= bbox_bottom-1{
		if !_bottomWall	|| _listInst.bbox_top < _bottomWall.bbox_top{
			_bottomWall = _listInst;	
		}
	}
	//Top Wall
	if _listInst.bbox_bottom - _listInst.yspd <= bbox_top+1{
		if !_topWall || _listInst.bbox_bottom > _topWall.bbox_bottom{
			_topWall = _listInst;	
		}
	}
}

//Destroy the ds list to free memory
ds_list_destroy(_list);

//Get out of the walls
//Right Wall
if instance_exists(_rightWall){
	var _rightDist = bbox_right - x;
	x = _rightWall.bbox_left - _rightDist;
}
//Left Wall
if instance_exists(_leftWall){
	var _leftDist = x - bbox_left;
	x = _leftWall.bbox_right + _leftDist;
}
//Bottom Wall
if instance_exists(_bottomWall){
	var _bottomDist = bbox_bottom - y;	
	y = _bottomWall.bbox_top - _bottomDist;
}
//Top Wall (Includes collision for polish and crouching features)
if instance_exists(_topWall){
	var _upDist = y-bbox_top;
	var _targetY = _topWall.bbox_bottom+_upDist;
	//Check if there isnt a wall in the way
	if !place_meeting(x,_targetY,oWall){
		y = _targetY;	
	}
}
#endregion

#region Dont get left behind by my moveplat!!
earlyMoveplatXspd = false;
if instance_exists(myFloorPlat) && myFloorPlat.xspd !=0 && !place_meeting(x,y+moveplatMaxYspd+1,myFloorPlat){
		//Go ahead and move outselves back onto that platform if there is no wall in the way
		if !place_meeting(x+myFloorPlat.xspd,y,oWall){
			x+=myFloorPlat.xspd;
			earlyMoveplatXspd = true;
		}
}
#endregion

#region Check if im "crushed"
image_blend = c_white;
if place_meeting(x,y,oWall) image_blend = c_blue;

#endregion

#region Crouching
//Transition to Crouch
	//Manual = downkey | Automatic = wall collision
	if onGround && (downKey || place_meeting(x,y,oWall)) && !attackStart && !isGrabbing && !isDead{
		crouching = true;
	}
	//Change collision mask
	if crouching {mask_index=crouchSpr};

//Transition out of Crouch
	//Manual = !downkey | Automatic = !onGround
	if crouching && (!downKey || !onGround){
		//Check if I CAN uncrouch
		mask_index = idleSpr;
		//Uncrouch if no solid wall in the way
		if !place_meeting(x,y,oWall){
			crouching = false;	
		}
		//Go back to crouching mask index if we cant uncrouch
		else{
			mask_index = crouchSpr;	
		}
	}
#endregion

#region Melee Attack

if onGround && attackKey && attackDelay<=0 && !beingHitted && !isGrabbing && !isDead{
	image_index = 0;
	moveSpd[0] = 0;
	moveSpd[1] = 0;
	crouching = false;
	attackStart = true;
	attackDelay = attackFrames;
	var _hitbox = instance_create_depth(x,y,self.depth-1,oPlayer_Attack_HB);
	with(_hitbox){
		x=other.x+(8*other.face);
		y=other.y;
		self.image_xscale = self.image_xscale*other.face;
	}
}

if attackStart {
    xspd = 0; // Asegura que no pueda moverse mientras ataca

    if !onGround || image_index >= image_number - 1 { 
        moveSpd[0] = walkSpd;
        moveSpd[1] = runSpd;
		image_index = 0;
        attackStart = false;
    }
}

if !attackStart && attackDelay>=0{
	attackDelay--;
}

#endregion

#region Air Spin Attack

if !onGround && (attackKey || airAttackBuffered) && airAttackDelay<=0 && !isGrabbing && !beingHitted && !isDead{
	airAttackStart = true;
	if airAttackHB == noone{
		airAttackHB = instance_create_depth(x,y,depth,oPlayer_Air_Attack_HB);
	}
}

//Si estoy atacando en el aire se cree el hitbox para el golpe
if airAttackStart{
	with(airAttackHB){
		self.x = other.x;
		self.y = other.y+2;
	}
}

if beingHitted || !airAttackStart{
	instance_destroy(airAttackHB);
	airAttackHB = noone;
}

#endregion

#region X Movement
	//Direction
	if !beingHitted && !isDead{
		moveDir = rightKey - leftKey;
	}
	
	//Cant change face while attacking
	if(!attackStart && !beingHitted && !isDead){
		//Get my face
		if moveDir > 0 face=1;
		if moveDir < 0 face=-1;
	}
	
	//No movement while crouching
	if crouching && !beingHitted  { moveDir = 0;};

	//Get xspd
	if !attackStart{
		runType = runKey;
		xspd = moveDir * moveSpd[runType];
	}
	

	//X collision
	var _subPixel = .5;
	if place_meeting(x+xspd, y, oWall){
		//First check if there is a slope to go up
		if !place_meeting(x+xspd,y-abs(xspd)-1,oWall){
			while place_meeting(x+xspd,y,oWall){ y-=_subPixel};
		}
		//Next, check for ceiling slopes, otherwise, do a regular collision
		else{
			//Ceiling Slopes
			if(!place_meeting(x+xspd,y+abs(xspd)+1,oWall)){
				while place_meeting(x+xspd,y,oWall) {y+= _subPixel}	
			}
			//Normal Collision
			else{
				//Scoot up to wall precisely
				var _pixelCheck = _subPixel * sign(xspd);
				while !place_meeting(x + _pixelCheck, y,oWall){
					x+=_pixelCheck;
				}
				//Set xspd to zero to "collide"
				xspd = 0;
			}
		}	
	}
	
	//Go down Slopes
	downSlopeSemiSolid = noone;
	if yspd >= 0 && !place_meeting(x+xspd,y+1,oWall) && place_meeting(x+xspd,y+abs(xspd),oWall){
		//Check for a semisolid in the way
		downSlopeSemiSolid = checkForSemiSolidPlatform(x+xspd,y+abs(xspd)+1);
		//Precisely move down slope if there isnt a semisolid in the way
		if !instance_exists(downSlopeSemiSolid){
			while !place_meeting(x+xspd,y+_subPixel,oWall){
				y+=_subPixel
			}	
		}
	}
	//Move
	x+= xspd;

#endregion
	
#region Y Movement
	//Gravity
	if( coyoteHangTimer>0){
		coyoteHangTimer--;	
	}else{
		//Apply gravity to the player
		yspd += grav;
		//We're no longer on the ground
		setOnGround(false);
	}
	
	//Reset/Prepare jumping variables
	if onGround{
		jumpCount=0;
		coyoteJumpTimer = coyoteJumpFrames;
	}else{
		//if the player is in the air, make sure they cant do an extra jump
		coyoteJumpTimer--;
		if (jumpCount == 0) && (coyoteJumpTimer <= 0){
			jumpCount = 1;
		}
	}
	
	//Cap falling speed
	if yspd > termVel {yspd = termVel};
	
	//Initiate the Jump
	var _floorIsSolid = false;
	if instance_exists(myFloorPlat)
	&& (myFloorPlat.object_index == oWall || object_is_ancestor(myFloorPlat.object_index,oWall)){
		_floorIsSolid = true;	
	}
	
	if (jumpKeyBuffered && jumpCount<jumpMax && (!downKey || _floorIsSolid)  && !attackStart && !isDead){
		//Reset the Buffer
		jumpKeyBuffered = false;
		jumpKeyBufferTimer = 0;
		//Increase the number of performed jumps
		jumpCount++;
		//Set the jump hold timer
		jumpHoldTimer = jumpHoldFrames;
		
		//Tell ourself we are no longer on the ground
		setOnGround(false);
	}
	//Cut off the jump by releasing the jump button
	if !jumpKey{
		jumpHoldTimer=0;
	}
	//Jump based on the timer/holding the button
	if jumpHoldTimer>0{
		//Constantly set the yspd to be jumping speed
		yspd=jspd;
		//Count down the timer
		jumpHoldTimer--;
	}
	
	//Y Collision
	var _subPixel = .5;
	
	//Upwards Y Collisions (with ceiling slopes)
	if((yspd<0) && (place_meeting(x,y+yspd,oWall))){
		//Jump into sloped ceilings
		var _slopeSlide=false;
		
		//Slide Upleft slope
		if(moveDir==0) && !place_meeting(x-abs(yspd)-1,y+yspd,oWall){
			while place_meeting(x,y+yspd,oWall){
				x-=1;
			}
			_slopeSlide=true;
		}
		//Slide UpRight slope
		if(moveDir==0) && !place_meeting(x+abs(yspd)+1,y+yspd,oWall){
			while place_meeting(x,y+yspd,oWall){
				x+=1;	
			}
			_slopeSlide=true;
		}
		
		//Normal Y Collision
		if(!_slopeSlide){
			//Scoot up to the wall precisely
			var _pixelCheck = _subPixel*sign(yspd);
			while !place_meeting(x,y+_pixelCheck, oWall){
				y += _pixelCheck;	
			}
			//bonk (OPTIONAL)
			if(yspd < 0){
				jumpHoldTimer = 0
			}
			//Set yspd to zero to collide
			yspd = 0;
		}
	}
	
	//Floor Y Collision
	
	//Check for solid and semisolid platforms under me
	var _clampYspd = max(0,yspd);
	var _list = ds_list_create(); //Create a DS list to store all of the objects we run into
	var _array = array_create(0);
	array_push(_array, oWall,oSemiSolidWall);
	
	//Do the actual check and add objects to list
	var _listSize=instance_place_list(x,y+1+_clampYspd+moveplatMaxYspd,_array,_list,false);
	
	/* ------ Fix for high resolution/hight speed projects -----*/
	var _yCheck = y+1 + _clampYspd;
	if instance_exists(myFloorPlat) _yCheck += max(0, myFloorPlat.yspd);
	var _semiSolid = checkForSemiSolidPlatform(x,_yCheck)
	
	//Loop through the colliding instances and only return one if its top is bellow the player
	for( var i=0; i< _listSize; i++){
		//Get an instance of oWall or oSemiSolidWall from the list
		var _listInst = _list[| i];
		
		//Avoid magnetism
		if _listInst != forgetSemiSolid
		&& ( _listInst.yspd <= yspd || instance_exists(myFloorPlat) )
		&& ( _listInst.yspd > 0 || place_meeting(x,y+1+_clampYspd, _listInst) )
		|| ( _listInst == _semiSolid) ///// (HIGH SPEED FIX)
		{
			//Return a solid wall or any semisolid walls that are below the player
			if(_listInst.object_index == oWall)
			|| object_is_ancestor(_listInst.object_index,oWall)
			|| floor(bbox_bottom)<= ceil(_listInst.bbox_top - _listInst.yspd)
			{
				//Return the "highest" wall object
				if (!instance_exists(myFloorPlat)) 
				|| (_listInst.bbox_top + _listInst.yspd<=myFloorPlat.yspd)
				|| (_listInst.bbox_top + _listInst.yspd<= bbox_bottom)
				{
					myFloorPlat = _listInst;	
				}
			}
		}
	}
	//Destroy the DS list to avoid a memory leak
	ds_list_destroy(_list);
	
	//Downslope semisolid for making sure we dont miss semisolid while going down slopes
	if instance_exists(downSlopeSemiSolid) myFloorPlat = downSlopeSemiSolid;
	
	//One last check to make sure the floor platform is actually bellow us
	if( (instance_exists(myFloorPlat)) && (!place_meeting(x,y+moveplatMaxYspd,myFloorPlat)) ){
		myFloorPlat = noone;	
	}
	
	//Land on the ground platform if there is one
	if(instance_exists(myFloorPlat)){
		//Scoot up to our wall precisely
		var _subPixel = .5;
		while ( (!place_meeting(x,y+_subPixel, myFloorPlat)) && (!place_meeting(x,y,oWall)) ){
			y+=_subPixel;	
		}
		//Make sure we dont end up below the top of a semisolid
		if( (myFloorPlat.object_index == oSemiSolidWall) || (object_is_ancestor(myFloorPlat.object_index,oSemiSolidWall)) ){
			while(place_meeting(x,y,myFloorPlat)){
				y-=_subPixel;	
			}
		}
		//Floor the y variable
		y = floor(y);
		
		//Collide with the ground
		yspd = 0;
		setOnGround(true);
	}
	
	//Manually Fall Through a semisolid platform
	if downKey && jumpKeyPressed{
		//Make sure we have a floor platform thats a semisolid
		if instance_exists(myFloorPlat)
		&& (myFloorPlat.object_index == oSemiSolidWall || object_is_ancestor(myFloorPlat.object_index,oSemiSolidWall)){
			//Check if we CAN go below the semisolid
			var _yCheck = max(1,myFloorPlat.yspd+1);
			if !place_meeting(x,y+_yCheck,oWall){
				//Move below the platform
				y+=1;
				
				//Inherit any downward speed form my floor platform so it doesnt cartch me
				yspd = _yCheck-1;
				
				//Forget this platform for a brief time so we dont get caught again
				forgetSemiSolid = myFloorPlat;
				
				//No more floor Platform
				setOnGround(false);
			}
		}
	}
	
	//Move
	if !place_meeting(x,y+yspd,oWall){
		y+=yspd;
	}
	
	//Reset forgetSemiSolid variable
	if instance_exists(forgetSemiSolid) && !place_meeting(x,y,forgetSemiSolid){
		forgetSemiSolid = noone;	
	}
		
#endregion
	
#region Final moving platform collisions and movement

//X - moveplatXspd and collision
//Get the MoveplatXspd
movePlatXspd = 0;
if instance_exists(myFloorPlat) movePlatXspd = myFloorPlat.xspd;

//Move with moveplatXspd
if !earlyMoveplatXspd{
	if place_meeting(x+movePlatXspd,y,oWall){
		//Scoot up to wall precisely
		var _subPixel = .5;
		var _pixelCheck = _subPixel*sign(movePlatXspd);
		while !place_meeting(x+_pixelCheck,y,oWall){
			x+=_pixelCheck;	
		}
		//Set moveplatXspd to 0 to finish the collision
		movePlatXspd = 0;
	}
	//Move
	x+=movePlatXspd;
}


//Y - snap myself to myFloorPlat if its moving vertically
if instance_exists(myFloorPlat) 
&& (myFloorPlat != 0
|| myFloorPlat.object_index == oMovePlat
|| object_is_ancestor(myFloorPlat.object_index,oMovePlat)
|| myFloorPlat.object_index == oSemiSolidMovePlat
|| object_is_ancestor(myFloorPlat.object_index,oSemiSolidMovePlat)){
	//Snap to the top of the floor platform (un-floor our Y variable so its not choppy)
	if !place_meeting(x,myFloorPlat.bbox_top, oWall)
	&& myFloorPlat.bbox_top>= bbox_bottom
	{
		y = myFloorPlat.bbox_top;
	}
}

//Get push down through a semisolid by a moving solid platform
if instance_exists(myFloorPlat)
&&(myFloorPlat.object_index == oSemiSolidWall || object_is_ancestor(myFloorPlat.object_index,oSemiSolidWall))
&& place_meeting(x,y,oWall){
	//If im already stuck in a wall at this point, try and move me down to get below a semisolid
	//if im still stuck afterwards, that just means ive been properly "crushed"
	
	//Also, dont check too far, we dont want to warp below walls
	var _maxPushDist = 10;
	var _pushedDist = 0;
	var _startY = y;
	while place_meeting(x,y,oWall) && _pushedDist <= _maxPushDist{
		y++;
		_pushedDist++;
	}
	//Forget myFloorPlat
	myFloorPlat = noone;
	
	//if im still in a wall at this point, ive been crushed regardless, take me back to my start y to avoid the funk
	if _pushedDist > _maxPushDist {y = _startY};
}

#endregion

#region Poleas

if instance_exists(myFloorPlat) {
    // Si estamos sobre una plataforma del tipo oPolleyPlat
    if myFloorPlat.object_index == oPolleyPlat {
        if onPulleyPlatform != myFloorPlat {
            // Solo asignamos si no es la misma plataforma de antes
            onPulleyPlatform = myFloorPlat;
            onPulleyPlatform.canMove = true;
        }
    } else if instance_exists(onPulleyPlatform) {
        // Si hemos cambiado de plataforma y antes estábamos en una Polley, la desactivamos
        onPulleyPlatform.canMove = false;
        onPulleyPlatform = noone;
    }
} else {
    // Si ya no estamos sobre ninguna plataforma, desactivamos la anterior si existía
    if instance_exists(onPulleyPlatform) {
        onPulleyPlatform.canMove = false;
    }
    onPulleyPlatform = noone;
}

#endregion

#region Agarrar y tirar objetos

if !isGrabbing && onGround{
	if instance_place(x+(1*face),y,oGrabbable) && glideKey{
		grabbed = instance_place(x+(1*face),y,oGrabbable);
		if(grabbed.estado==States.IdleOn || grabbed.estado==States.IdleOff ){
			isGrabbing = true;
			grabbed.estado = States.Grabbed;
			grabbed.owner = id;
		}
	}
}
if isGrabbing && attackKey{
	/*with grabbed{
		self.grabbed = false;
		self.owner = noone;
		self.face = other.face;
		self.flying = true;
		self.hsp += (other.xspd/3)*other.face;
	}*/
	grabbed.hsp += grabbed.throwHsp*face;
	grabbed.vsp = grabbed.throwVsp;
	grabbed.estado = States.Flying;
	grabbed.x += 3*face;
	
	airAttackDelay = airAttackFrame; //Evita que player pegue al soltar
	isGrabbing = false;
}

#endregion

#region Romper cajas cayendo encima

var _breakThreshold = 3.5; // Velocidad mínima para romperla
smallBox = instance_place(x,y+yspd,oSmallBox)
if smallBox != noone && !onGround && !instance_exists(airAttackHB){
	if yspd >= _breakThreshold{
		yspd=-5;
		smallBox.Destroy();
	}
}

#endregion

#region Trampolin

var _trampolinePower = 0;
if instance_place(x,y+1,oTrampoline) && !beingHitted{
	if jumpKey _trampolinePower = -7;
	else _trampolinePower = -5
	
	//jumpKeyBuffered = true;  // Activa el buffer de salto
	jumpHoldFrames = 0;
	jumpKeyBufferTimer = 1;  // Simula el tiempo de presionado
	//jumpCount = min(jumpCount, jumpMax - 1); // Asegura que no se excedan los saltos
	yspd=_trampolinePower;
}

#endregion

#region Mover Objetos

var _moveObject = instance_place(x+(1*face),y,oMoveObject);
if glideKey && _moveObject!=noone && onGround && moveDir!=0 && !isGrabbing{
	with(_moveObject){
		if !instance_place(x+(1*other.face),y,oWall){
			self.x += other.moveDir*1;
			self.hsp = other.moveDir*1;
			cameraShake(0.3,1);
			if self.objTop != noone{
				self.objTop.face = other.face;
				if self.objTop.canMove{
					self.objTop.x += other.moveDir*1;
				}
			}
		}else{
			//Aca se podria hacer que se puedan mover de a varias horizontalmente
		}
	}
}

#endregion

#region Take Damage Delay
if(!beingHitted && alreadyHit && !isDead){
	invulTimer --;	
	if invulTimer <= 0 alreadyHit = false;   //player can take dmg again
	
	var _t = invulTimer/invulFrames;
	
	// Calcular frecuencia de parpadeo (rápido al inicio, lento al final)
    var _blinkSpeed = 1+(_t*2); //Mas alto el numero '8, mas fura la fase rapida.
	if _blinkSpeed > 0.5{
		image_alpha = (floor(invulTimer/_blinkSpeed) mod 2); // Alterna entre 0 y 1
	}
}
if (invulTimer <= 0) {
	image_alpha = 1; // Asegurar visibilidad
}
#endregion

#region Muerte de Player

if global.Player_Hp<=0 && onGround{
	isDead = true;
}
	
if isDead{
	moveDir = 0;
	roomTransition_delay--;
}

if roomTransition_delay<=0{
	if !instance_exists(oTransition){
		var _transition = instance_create_depth(x,y,-10000,oTransition);	
		_transition.targetRoom = room;
	}
}

#endregion

#region Sprite Control
//Runing
if(abs(xspd)>=moveSpd[1]){sprite_index = runSpr};

//Walking
if( (abs(xspd)>0) && (abs(xspd)<moveSpd[1]) ) {sprite_index = walkSpr};

//Not Moving
if(xspd==0) && !isDead {sprite_index = idleSpr};

//In the air
if !onGround && !airAttackStart && !beingHitted {sprite_index = jumpSpr};

//Crouching
if crouching {sprite_index = crouchSpr};

//Gliding
if glideStart {sprite_index = glideSpr};

//Melee Attack
if attackStart {sprite_index = attackSpr};

//Air Attack
if airAttackStart {sprite_index = AirAttackSpr};

if beingHitted{
	sprite_index = hittedSpr
	if (image_index >= image_number - 1) {
	    image_index = image_number - 1; // Fijar el último frame
	    //image_speed = 0; // Congelar la animación
	}
}

if isDead {
	if (sprite_index != deathSpr) { 
        sprite_index = deathSpr;
        image_index = 0; // Reiniciar desde el primer frame
    }
    // Si la animación llegó al último frame, detenerla
    if (image_index >= image_number - 1) {
        image_index = image_number - 1; // Fijar el último frame
        image_speed = 0; // Detener animación
    }
}

//Set the collision mask
mask_index = idleSpr;
if crouching{mask_index=crouchSpr};

#endregion