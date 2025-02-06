event_inherited();

function Destroy(){
	for(var i=8; i>=0;i--){
		instance_create_depth(x,y,depth,oTntBox_Breaked);	
	}
	instance_create_depth(x,y-(sprite_height/2),depth,oSmallBox_Smoke);
	instance_create_depth(x,y,depth,oBomb_Explosion);
	cameraShake(10,5);
	instance_destroy();	
}