
if(grabbed){
	x=owner.x + 15*owner.face;
	y=owner.y-5;
	mask_index = sNoMask;
}

else{
	mask_index = sGrabbable;	
}

if flying{
	x+=throwXSpd*face;
	vspeed += grv;
	y+=vspeed;
}

if (instance_place(x,y,oWall) || instance_place(x,y,oSemiSolidWall)) && flying{
	if !canExplode{
		vspeed=throwYSpd;
		bounceCount--;
		
	}
	else instance_destroy();
}

if bounceCount <= 0 canExplode=true;