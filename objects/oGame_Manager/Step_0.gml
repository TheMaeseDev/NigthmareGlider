
if (global.Room_SpecialBox_Broken >= global.Room_SpecialBox_inRoom && !global.Room_SpecialBox_Completed) {
    global.Player_Power += 1; // Aumentar el poder del jugador
    global.Room_SpecialBox_Completed = true; // Evita que se sume más de una vez
}


// Si todas las piezas fueron recolectadas, activa el mapa completo
if array_length(global.Room_MapPieces) == 4 && !array_contains(global.Room_MapPieces, false) {
   global.has_full_map = true;
}

if global.Player_Coins>=100{
	global.Player_Lives++;
	global.Player_Coins=0;
}

if global.Player_Lives < 0{
	game_restart();	
}