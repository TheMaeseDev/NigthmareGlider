event_inherited();

function Destroy(){
	for(var i=8; i>=0;i--){
		with instance_create_depth(x,y,depth,oSmallBox_Breaked) image_blend = c_aqua;
	}
	with instance_create_depth(x,y-(sprite_height/2),depth,oSmallBox_Smoke) image_blend = c_aqua;
	cameraShake(1,5);
	instance_destroy();	
}

image_blend = c_aqua;