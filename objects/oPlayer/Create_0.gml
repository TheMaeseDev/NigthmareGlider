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
			if floor(bbox_bottom)<= ceil(_listInst.bbox_top - _listInst.yspd){
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
downSlopeSemiSolid = noone;
forgetSemiSolid = noone;
movePlatXspd = 0;
moveplatMaxYspd = termVel;

