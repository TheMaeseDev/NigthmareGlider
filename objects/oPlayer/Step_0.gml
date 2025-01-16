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
	if( coyoteHangTimer>0){
		coyoteHangTimer--;	
	}else{
		//Apply gravity to the player
		yspd += grav;
		//We're no longer on the ground
		setOnGround(false);
	}
	yspd += grav;
	
	//Reset/Prepare jumping variables
	if onGround{
		jumpCount=0;
	}else{
		//if the player is in the air
		if (jumpCount == 0) jumpCount = 1;
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
	if place_meeting(x,y+yspd,oWall){
		//Scoot up to the wall precisely
		var _pixelCheck = _subPixel*sign(yspd);
		while !place_meeting(x,y+_pixelCheck, oWall){
			y += _pixelCheck;	
		}
		
		//Set yspd to zerp tp collide
		yspd = 0;
	}
	
	//Set if im on the ground
	if (yspd >=0 && place_meeting(x,y+1,oWall)){
		setOnGround(true);
	}
	//Move
	y+=yspd;