//Custom functions for player
function setOnGround(_val = true){
	if(_val){
		onGround = true;
		coyoteHangTimer=coyoteHangFrames;
		termVel = defaultTermVel;
		glideStart = false;
		airAttackStart = false;
		airAttackDelay = airAttackFrame;
		beingHitted = false;
		grav = defaultGrav;	  //set grv back to default
		jumpHoldFrames = 10; //reset var
		moveSpd[1] = runSpd;
		
	}else{
		onGround = false;
		myFloorPlat = noone;
		coyoteHangTimer=0;
		airAttackDelay--; //Descuenta el delay de ataque aereo
		smallBox = noone;
	}
}

function takeDamage(_dmg,_attackX){
	if !alreadyHit{
		//Manejo de flags
		alreadyHit = true;
		beingHitted = true;
		invulTimer = invulFrames;
		
		//Cancelar ataque en curso
		attackStart = false;
		moveSpd[0] = walkSpd;
		moveSpd[1] = walkSpd;
		//if airAttackHB instance_destroy(airAttackHB);
		
		//Restar vida
		global.Player_Hp = max(global.Player_Hp - _dmg, 0);
		
		/*------- Y Knockback ----------- */
		grav = defaultGrav/1.5; //opcional si queremos la caida mas lenta
		yspd = 0; 
		yspd += -3;
		
		// "despegar al player del suelo"
	    jumpKeyBuffered = true;  // Activa el buffer de salto
		jumpHoldFrames = 1;
	    jumpKeyBufferTimer = jumpHoldFrames;  // Simula el tiempo de presionado
		jumpCount = min(jumpCount, jumpMax - 1); // Asegura que no se excedan los saltos
		//jumpHoldTimer=0;
		
		/*------- X Knockback ----------- */
		// Determina la dirección del golpe
	    if (_attackX < x) face = -1;  // Golpe desde la izquierda → Empuja a la derecha  
	    else face = 1; // Golpe desde la derecha → Empuja a la izquierda 
	    //Mover horizontalmente a Player
		moveDir = -face;
		
		//Manejo de sprite
		image_index = 0;
		
		//Que pasa con el objeto "agarrado"
		if isGrabbing{
			with(grabbed) Destroy();
			isGrabbing = false;
		}
	}
}

function checkForSemiSolidPlatform(_x,_y){
	//Create a return variable
	var _rtrn = noone;
	
	//We must not be moving upwards, and then we check for a normal collision
	if yspd>=0 && place_meeting(_x,_y,oSemiSolidWall){
		//Create a ds list to store all collising instanes of oSemiSolidWall
		var _list = ds_list_create();
		var _listSize = instance_place_list(_x,_y,oSemiSolidWall,_list,false);
		
		//Loop through the colliding instances and only return one of its top is below the player
		for(var i=0 ; i<_listSize ; i++){
			var _listInst = _list[|i];
			if _listInst != forgetSemiSolid && floor(bbox_bottom)<= ceil(_listInst.bbox_top - _listInst.yspd){
					//Return the id of a semisolid plarform
					_rtrn = _listInst;
					//Exit the loop early
					i = _listSize;
			}
		}
		//Destroy ds list to free memory
		ds_list_destroy(_list);
	}
	//Return out variable
	return _rtrn;
}

depth = -30;

hp = 7;
coins = 0;
Lives = 2;

beingHitted = false;
alreadyHit = false;
invulTimer = 0;
invulFrames = 90;


//ControlSetup
controlsSetup();

//Sprites
idleSpr = sPlayer_Idle;
walkSpr = sPlayer_Walk;
runSpr = sPlayer_Run;
jumpSpr = sPlayer_Jump;
crouchSpr = sPlayer_Crouch;
glideSpr = sPlayerGlid;
attackSpr = sPlayer_Attack;
attackSpr1=sPlayer_Attack_1;
attackSpr2=sPlayer_Attack_2;
AirAttackSpr = sPlayer_Air_Attack;
hittedSpr = sPlayer_Hit;
deathSpr = sPlayer_Death;
moveObjectSpr = sPlayer_Push

//Moving
face = 1;
moveDir = 0;
runType = 0;
walkSpd = 2.3;
runSpd = 3;
moveSpd[0] = walkSpd;	  //Caminando
moveSpd[1] = runSpd; //Corriendo 3 default
xspd = 0;
yspd = 0;

//State variables
crouching = false;
isDead = false;

//Jumping
defaultGrav = .275;
defaultTermVel = 4;
grav = defaultGrav;   //Gravedad actual
termVel = defaultTermVel;   //Velocidad maxima de caida
onGround = true;
jspd = -3.50;  //Velocidad de salto
jumpMax = 1;
jumpCount = 0;
jumpHoldTimer = 0;
jumpHoldFrames = 10;
//Coyote Time
//Hang time
coyoteHangFrames = 3;
coyoteHangTimer = 0;
//Coyote buffer time
coyoteJumpFrames = 7;
coyoteJumpTimer = 0;

//Gliding
glideStart = false; // Controla si se ha comenzado a planear
glideTermVel = 1.5;

//Melee Attack
attackStart = false; //Controla si se ha comenzado a atacar
attackDelay = 0;
attackFrames = 10;
attackStep = 0; //En que ataque esta?
canCombo = false; //Puede realizar otro ataque?
comboFrames = 10 //Tiempo para encadenar combo
comboTimer = comboFrames; //Cuenta regresiva para encadenar otro combo

//Air Attack
airAttackStart = false; //Controla si se ha comenzado el ataque aereo
airAttackDelay = 0;
airAttackFrame = 7;
airAttackHB = noone;

//Grab Mechanic
isGrabbing = false;
grabbing = noone;
smallBox = noone;

//Moving Platforms
myFloorPlat = noone;
earlyMoveplatXspd = false;
downSlopeSemiSolid = noone;
forgetSemiSolid = noone;
movePlatXspd = 0;
moveplatMaxYspd = termVel;

//Polley PLatforms
onPulleyPlatform = noone; // Almacena la referencia de la plataforma en la que está parado

//Death Event
roomTransition_delay = 60;

//Moving objects mechanic
grabbedObject = noone;
isMovingObject = false;
grabSpd = 2.3; // Velocidad de arrastre

//Crushed mechanic
crushedFrames = 10;
crushedTimer = crushedFrames;
canUnstuck = true;

global.mensaje = "";