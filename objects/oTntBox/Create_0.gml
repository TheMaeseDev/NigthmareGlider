event_inherited();

function Destroy(){
	for(var i=8; i>=0;i--){
		instance_create_depth(x,y,depth,oTntBox_Breaked);	
	}
	instance_create_depth(x,y-(sprite_height/2),depth,oSmallBox_Smoke);
	instance_create_depth(x,y,depth,oBomb_Explosion);
	cameraShake(10,5);
	if (!(ds_list_find_index(global.currentState, myId) >= 0)) { // Si el ID no está en la lista
	    ds_list_add(global.currentState, myId); // Guardarlo en currentState
	}
	instance_destroy();	
}