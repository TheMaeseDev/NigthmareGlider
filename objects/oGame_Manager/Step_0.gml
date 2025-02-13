
if (global.Room_SpecialBox_Broken >= global.Room_SpecialBox_inRoom && !global.Room_SpecialBox_Completed) {
    global.Player_Power += 1; // Aumentar el poder del jugador
    global.Room_SpecialBox_Completed = true; // Evita que se sume más de una vez
}

global.mensaje = "SB "+string(global.Room_SpecialBox_inRoom - global.Room_SpecialBox_Broken ) +
			     " L "+string(global.Player_Lives) +
				 "P " +string(global.Player_Power);