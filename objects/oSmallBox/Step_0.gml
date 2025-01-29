//Follow Player
if(grabbed){
	x=owner.x + 15*owner.face;
	y=owner.y-5;
	mask_index = sNoMask;
}
else{
	mask_index = sSmallBox;	
}

if flying{
	vsp += grv;
	x+=hsp*face;
	y+=vsp;
	
	if place_meeting(x,y+1,oWall){
		//y-=1;
		/*vsp *= -bounce_factor;
		hsp *= xFriction;
		//Detener si la energia de rebote es muy baja
		if(abs(vsp)<1){
			vsp = 0;	
		}
		if(abs(hsp)< 0.1){
			hsp = 0;	
		}*/
		instance_destroy();
	}
}