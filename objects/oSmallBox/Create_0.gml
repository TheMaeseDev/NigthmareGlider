event_inherited();

function Destroy(){
	for(var i=8; i>=0;i--){
		instance_create_depth(x,y,depth,oSmallBox_Breaked);
	}
	instance_create_depth(x,y-(sprite_height/2),depth,oSmallBox_Smoke);
	for(var i=3; i>=0;i--){
		var _coin = instance_create_depth(x,bbox_top,depth,oCollectable_Coin);
		_coin.behaviour=Behaviour.bounce;
		_coin.vsp = random_range(-5,-7);
		_coin.hsp = random_range(-3,3);
	}
	cameraShake(1,5);
	if (!(ds_list_find_index(global.currentState, myId) >= 0)) { // Si el ID no está en la lista
	    ds_list_add(global.currentState, myId); // Guardarlo en currentState
	}
	instance_destroy();
}

//Box Throwed Mechanic
grv = 0.275;

//Velocidades al ser lanzadas
throwHsp = 5;
throwVsp = -4;