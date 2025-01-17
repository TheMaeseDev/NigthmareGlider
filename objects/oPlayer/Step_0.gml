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
	if yspd >= 0 && !place_meeting(x+xspd,y+1,oWall) && place_meeting(x+xspd,y+abs(xspd),oWall){
		while !place_meeting(x+xspd,y+_subPixel,oWall){
			y+=_subPixel
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
	
	//Downwards Y Collisions
	if yspd >=0{
		if place_meeting(x,y+yspd,oWall){
			//Scoot up to the wall precisely
			var _pixelCheck = _subPixel*sign(yspd);
			while !place_meeting(x,y+_pixelCheck, oWall){
				y += _pixelCheck;	
			}

			//Set yspd to zero to collide
			yspd = 0;
		}
	
		//Set if im on the ground
		if (place_meeting(x,y+1,oWall)){
			setOnGround(true);
		}
	}
	//Move
	y+=yspd;
	
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
