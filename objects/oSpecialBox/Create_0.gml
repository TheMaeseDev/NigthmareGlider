event_inherited();

function Destroy(){
	for(var i=8; i>=0;i--){
		with instance_create_depth(x,y,depth,oSmallBox_Breaked) image_blend = c_aqua;
	}
	with instance_create_depth(x,y-(sprite_height/2),depth,oSmallBox_Smoke) image_blend = c_aqua;
	cameraShake(1,5);
	global.Room_SpecialBox_Broken++;
	if (!(ds_list_find_index(global.currentState, myId) >= 0)) { // Si el ID no está en la lista
	    ds_list_add(global.currentState, myId); // Guardarlo en currentState
	}
	instance_destroy();	
}