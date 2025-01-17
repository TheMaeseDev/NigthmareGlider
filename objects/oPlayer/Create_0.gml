//Custom functions for player
function setOnGround(_val = true){
	if(_val){
		onGround = true;
		coyoteHangTimer=coyoteHangFrames;
	}else{
		onGround = false;
		myFloorPlat = noone;
		coyoteHangTimer=0;
	}
}

depth = -30;

//ControlSetup
controlsSetup();

//Sprites
idleSpr = sPlayer_Idle;
walkSpr = sPlayer_Walk;
runSpr = sPlayer_Run;
jumpSpr = sPlayer_Jump;


//Moving
face = 1;
moveDir = 0;
runType = 0;
moveSpd[0] = 2;
moveSpd[1] = 3.5;
xspd = 0;
yspd = 0;


//Jumping
grav = .275;   //Gravedad
termVel = 10;   //Velocidad maxima de caida
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


//Moving Platforms
myFloorPlat = noone;
movePlatXspd = 0;
moveplatMaxYspd = termVel;

