
//Follow Player
if(grabbed){
	x=owner.x + 15*owner.face;
	y=owner.y-5;
	flying = false;
	hsp = 4.5;
	vsp = -4.5;
	mask_index = sNoMask;
}
else{
	mask_index = sBomb;	
}

if flying{
	vsp += grv;
	x+=hsp*face;
	y+=vsp;
	timerStart = true;
	
	if place_meeting(x,y+vsp,oWall) || place_meeting(x,y+vsp,oSemiSolidWall){
		vsp = max(vsp*-bounce_factor, -8);
		hsp *= xFriction;
		//Detener si la energia de rebote es muy baja
		if(abs(vsp)<0.5){
			vsp = 0;
		}
		if(abs(hsp)< 0.1){
			hsp = 0;	
		}
		if vsp == 0 || hsp == 0{
			y-=1;
			flying = false;
		}
	}
	if place_meeting(x+(1*face),y-1,oWall){
		instance_destroy();	
	}
}


//Codigo de explosion
if timerStart{
	timerFrames--	
}

if timerFrames<=0{
	instance_destroy();
}