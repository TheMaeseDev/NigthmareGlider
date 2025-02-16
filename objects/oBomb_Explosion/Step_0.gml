//No hace daño en sus ultimos frames
if(floor(image_index)>=3){
	mask_index = sNoMask;
}

//Si colisiona con una caja pequeña
if place_meeting(x,y,oSmallBox){
		var _collision = instance_place(x,y,oSmallBox);
		with _collision{
			Destroy();
		}
}

//Si colisiona con otra bomba
if place_meeting(x,y,oBomb){
		var _collision = instance_place(x,y,oBomb);
		with _collision{
			Destroy();
		}
}

//Si colisiona con el player
if place_meeting(x,y,oPlayer){
	var _collision = instance_place(x,y,oPlayer);
	with _collision{
		self.takeDamage(3,other.x);
	}
}