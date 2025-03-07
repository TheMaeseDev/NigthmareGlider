
if place_meeting(x,y,oPlayer){
	if (global.checkpointActive != id) {
		with(global.checkpointActive){
			sprite_index=sCheckpoint_Off;
		}
		sprite_index=sCheckpoint_On;
	    global.checkpointActive = id; // Guardamos este checkpoint como activo

	    // Guardar nueva posición de respawn
	    global.respawnX = oPlayer.x;
	    global.respawnY = oPlayer.y;
    
	    // Guardar el estado actual en savedState
	    for (var i = 0; i < ds_list_size(global.currentState); i++) {
		    ds_list_add(global.savedState, ds_list_find_value(global.currentState, i));
		}
		ds_list_clear(global.currentState); // Limpiar la lista actual
	}
}

if (global.checkpointActive == id) sprite_index=sCheckpoint_On;