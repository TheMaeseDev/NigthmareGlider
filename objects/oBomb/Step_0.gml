
//Follow Player
if(grabbed){
	x=owner.x + 15*owner.face;
	y=owner.y-5;
	flying = false;
	hsp = 4;
	vsp = -4;
	mask_index = sNoMask;
}
else{
	mask_index = sBomb;	
}

if flying{
	vsp += grv;
	x+=hsp*face;
	y+=vsp;
	
	if place_meeting(x,y+1,oWall){
		y-=1;
		vsp = max(vsp*-bounce_factor, -4);
		hsp *= xFriction;
		//Detener si la energia de rebote es muy baja
		if(abs(vsp)<1){
			vsp = 0;	
		}
		if(abs(hsp)< 0.1){
			hsp = 0;	
		}
	}
	/*if place_meeting(x+(1*face),y,oWall){
		instance_destroy();	
	}*/
}