
oPlayer.x = global.respawnX;
oPlayer.y = global.respawnY;

// Recorrer todos los objetos de la room
with (all) {
    if (variable_global_exists("savedState")) { 
        if (variable_instance_exists(id, "myId")) { // Verifica si la variable existe en la instancia
            if (ds_list_find_index(global.savedState, myId) >= 0) {
                instance_destroy(); // Destruir si está en la lista de guardados
            }
        }
    }
}

ds_list_clear(global.currentState); // Vaciar la lista, pero NO eliminar sus objetos