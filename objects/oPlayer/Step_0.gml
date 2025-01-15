//Get inputs
rightKey = keyboard_check(vk_right);
leftKey = keyboard_check(vk_left);


//X Movement
	//Direction
	moveDir = rightKey - leftKey;

	//Get xspd
	xspd = moveDir * moveSpd;

	//X collision
	var _subPixel = .5;
	if place_meeting(x+xspd, y, oWall){
		//Scoot up to wall precisely
		var _pixelCheck = _subPixel * sign(xspd);
		while !place_meeting(x + _pixelCheck, y,oWall){
			x+=_pixelCheck;
		}
		//Set xspd to zero to "collide"
		xspd = 0;	
	}

	//Move
	x+= xspd;