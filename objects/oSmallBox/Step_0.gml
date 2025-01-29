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
	
	if place_meeting(x,y,oWall) || place_meeting(x,y,oSemiSolidWall){
		Destroy();
	}
}