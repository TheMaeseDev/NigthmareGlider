//Get inputs
getControls();


//X Movement
	//Direction
	moveDir = rightKey - leftKey;
	//Get my face
	if(moveDir !=0) face=moveDir;

	//Get xspd
	runType = runKey;
	xspd = moveDir * moveSpd[runType];

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
	
// Y Movement
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
	if jumpKeyBuffered && jumpCount<jumpMax{
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
			if(yspd < 0) {jumpHoldTimer = 0};
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
		if ( _listInst.yspd <= yspd || instance_exists(myFloorPlat) )
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
	
	//Move
	y+=yspd;
	
/* --------- Final moving platform collisions and movement -------*/

//X - moveplatXspd and collision
//Get the MoveplatXspd
movePlatXspd = 0;
if instance_exists(myFloorPlat) movePlatXspd = myFloorPlat.xspd;

//Move with moveplatXspd
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

//Y - snap myself to myFloorPlat if its moving vertically
if instance_exists(myFloorPlat) && myFloorPlat != 0{
	//Snap to the top of the floor platform (un-floor our Y variable so its not choppy)
	if !place_meeting(x,myFloorPlat.bbox_top, oWall)
	&& myFloorPlat.bbox_top>= bbox_bottom
	{
		y = myFloorPlat.bbox_top;
	}
	
	//Going up into a solid wall while on a semisolid platform
	if myFloorPlat.yspd <0 && place_meeting(x,y+myFloorPlat.yspd, oWall){
		//Get pushed down through the semisolid floor platform
		if myFloorPlat.object_index == oSemiSolidWall || object_is_ancestor(myFloorPlat.object_index,oSemiSolidWall){
			//Get pushed down through semisolid
			var _subPixel = .25;
			while place_meeting(x,y+myFloorPlat.yspd,oWall){
				y+=_subPixel;	
			}
			//if we got pushed into a solid wall while going downwards, push ourselfves back out
			while place_meeting(x,y,oWall){
				y-= _subPixel;	
			}
			y = round(y);
		}
		//Cancel the myFloorPlat variable
		setOnGround(false);
	}
}



	
/* ---------- Sprite Control ------------ */
//Runing
if(abs(xspd)>=moveSpd[1]){sprite_index = runSpr};

//Walking
if( (abs(xspd)>0) && (abs(xspd)<moveSpd[1]) ) {sprite_index = walkSpr};



//Not Moving
if(xspd==0){sprite_index = idleSpr};

//In the air
if !onGround {sprite_index = jumpSpr};

//Set the collision mask
mask_index = idleSpr;
