//Follow Player
if(grabbed){
	x=owner.x + 15*owner.face;
	y=owner.y-5;
	vsp=0;
	mask_index = sNoMask;
}
else{
	mask_index = sSmallBox;	
}

if flying{
	if(!isFlying){
		hsp = 5;
		vsp = -4;
		isFlying = true;
	}
	
	if place_meeting(x+hsp*face,y+vsp,oSmallBox){
		var _collision = instance_place(x+hsp*face,y+vsp,oSmallBox);
		with _collision{
			Destroy();
		}
		Destroy();
	}
	
	if place_meeting(x,y+vsp,oWall) || place_meeting(x,y+vsp,oSemiSolidWall){
		Destroy();
	}
	
}else{
	if place_meeting(x,y,oPlayer_Attack_HB) || place_meeting(x,y,oPlayer_Air_Attack_HB){
		Destroy();	
	}	
}

var movement = object_movement(hsp,vsp,grv,face);
hsp = movement[0]; 
vsp = movement[1];

