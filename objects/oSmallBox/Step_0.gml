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
	
	if place_meeting(x,y,oSmallBox){
		var _collision = instance_place(x,y,oSmallBox);
		with _collision{
			Destroy();
		}
		Destroy();
	}
	
	if place_meeting(x,y,oEnemy){
		var _collision = instance_place(x,y,oEnemy);
		with _collision{
			self.getHitted(1);
		}
		Destroy();	
	}
	
	if place_meeting(x,y,oWall) || place_meeting(x,y,oSemiSolidWall){
		Destroy();
	}
}else{
	if place_meeting(x,y,oPlayer_Attack_HB) || place_meeting(x,y,oPlayer_Air_Attack_HB){
		Destroy();	
	}	
}