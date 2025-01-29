
//Follow Player
if(grabbed){
	x=owner.x + 15*owner.face;
	y=owner.y-5;
	mask_index = sNoMask;
}
else{
	mask_index = Sprite24;	
}

if flying{
	// Que pasa cuando es arrojado?
	if place_meeting(x+(1*face),y,oWall){
		instance_destroy();	
	}
}


