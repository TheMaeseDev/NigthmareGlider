//Get inputs
getControls();


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
	
	
// Y Movement
	//Gravity
	yspd += grav;
	
	//Cap falling speed
	if yspd > termVel {yspd = termVel};
	
	//Jump
	if jumpKeyBuffered && place_meeting(x,y+1,oWall){
		//Reset the Buffer
		jumpKeyBuffered = false;
		jumpKeyBufferTimer = 0;
		
		//set yspd to jump speed
		yspd = jspd;	
	}
	
	//Y Collision
	var _subPixel = .5;
	if place_meeting(x,y+yspd,oWall){
		//Scoot up to the wall precisely
		var _pixelCheck = _subPixel*sign(yspd);
		while !place_meeting(x,y+_pixelCheck, oWall){
			y += _pixelCheck;	
		}
		
		//Set yspd to zerp tp collide
		yspd = 0;
	}
	
	//Move
	y+=yspd;