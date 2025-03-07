event_inherited();

function Collected(){
	global.Player_Lives = min(global.Player_Lives + 3, global.Player_LivesMax);
	if (!(ds_list_find_index(global.currentState, myId) >= 0)) { // Si el ID no está en la lista
	    ds_list_add(global.currentState, myId); // Guardarlo en currentState
	}
	instance_destroy();
}

behaviour=Behaviour.idle;

myId = string(x)+" - "+string(y);