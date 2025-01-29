
if place_meeting(x,y,oSmallBox){
		var _collision = instance_place(x,y,oSmallBox);
		with _collision{
			Destroy();
		}
}

if place_meeting(x,y,oBomb){
		var _collision = instance_place(x,y,oBomb);
		with _collision{
			Destroy();
		}
}

if place_meeting(x,y,oEnemy){
	var _collision = instance_place(x,y,oEnemy);
	with _collision{
		self.getHitted(3);
	}
}