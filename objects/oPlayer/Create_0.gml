//Custom functions for player
function setOnGround(_val = true){
	if(_val){
		onGround = true;
		coyoteHangTimer=coyoteHangFrames;
	}else{
		onGround = false;
		coyoteHangTimer=0;
	}
}

//ControlSetup
controlsSetup();

//Moving
moveDir = 0;
moveSpd = 3.5;
xspd = 0;
yspd = 0;


//Jumping
grav = .375;   //Gravedad
termVel = 50;   //Velocidad maxima de caida
onGround = true;
jspd = -7.15;  //Velocidad de salto
jumpMax = 1;
jumpCount = 0;
jumpHoldTimer = 0;
jumpHoldFrames = 10;
//Coyote Time
//Hang time
coyoteHangFrames = 1000;
coyoteHangTimer = 0;
//Coyote buffer time
coyoteJumpFrames = 5;
coyoteJumpTimer = 0;

