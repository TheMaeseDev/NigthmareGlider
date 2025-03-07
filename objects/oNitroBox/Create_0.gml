
hsp = 0;
vsp = 0;
face = 1;

function Destroy(){
	for(var i=8; i>=0;i--){
		with instance_create_depth(x,y,depth-1,oTntBox_Breaked) image_blend = c_lime;
	}
	with instance_create_depth(x,y-(sprite_height/2),depth,oSmallBox_Smoke) image_blend = c_lime;
	with instance_create_depth(x,y,depth,oBomb_Explosion) image_blend = c_lime;
	cameraShake(10,15);
	
	if (!(ds_list_find_index(global.currentState, myId) >= 0)) { // Si el ID no está en la lista
	    ds_list_add(global.currentState, myId); // Guardarlo en currentState
	}
	instance_destroy();	
}

//noGrv = false;
if noGrv grv=0;
else grv = 0.275;

myId = string(x)+" - "+string(y);