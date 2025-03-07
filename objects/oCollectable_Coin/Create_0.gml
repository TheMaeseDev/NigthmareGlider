event_inherited();

function Collected(){
	global.Player_Coins++;
	global.hud_active[0] = true; // Activa la moneda
	global.hud_timer[0] = 60 * 2; // Se queda 2 segundos en pantalla
	instance_create_depth(x,y,depth,oCollectable_Coin_Taked);
	
	if (!(ds_list_find_index(global.currentState, myId) >= 0)) { // Si el ID no está en la lista
	    ds_list_add(global.currentState, myId); // Guardarlo en currentState
	}
	instance_destroy();
}

behaviour=Behaviour.idle;

delayToBeTaked = 10;
canBeTaked = false;

myId = string(x)+" - "+string(y);