event_inherited();

function Collected(){
	instance_create_depth(x,y,depth,oCollectable_MapPiece_Taked);
	global.Room_MapPieces[piece_index] = true;
	if (!(ds_list_find_index(global.savedState, myId) >= 0)) { // Si el ID no está en la lista
	    ds_list_add(global.savedState, myId); // Guardarlo en currentState
	}
	instance_destroy();
	
}

//piece_index = 0; // Se asignará al crear la instancia (0, 1, 2 o 3)

// Asignar el sprite correcto según la parte del mapa
switch (piece_index) {
    case 0: sprite_index = sCollectable_MapPiece0; break;
    case 1: sprite_index = sCollectable_MapPiece1; break;
    case 2: sprite_index = sCollectable_MapPiece2; break;
    case 3: sprite_index = sCollectable_MapPiece3; break;
}

myId = string(x)+" - "+string(y);