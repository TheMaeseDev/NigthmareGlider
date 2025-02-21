
// Si se tienen los 4 fragmentos y aún no se ha completado la animación
if (global.Room_MapPieces[0] && global.Room_MapPieces[1] && global.Room_MapPieces[2] && global.Room_MapPieces[3]) {
    if (map_merge_progress < 1) {
        map_merge_progress += map_animation_speed;
        if (map_merge_progress > 1) {
            map_merge_progress = 1; // Limitar el progreso a 1
        }
    }
}


// Mostrar/Ocultar HUD completo
if (keyboard_check_pressed(vk_tab)) {
    hud_visible = !hud_visible;
    hud_timer = 60 * 3; // Mantenerlo visible por 3 segundos
}

// Reducir el tiempo de cada elemento individual
for (var i = 0; i < 6; i++) {
    if (hud_timers[i] > 0) {
        hud_timers[i]--;
    }
}

// Ocultar HUD cuando el tiempo se acaba
if (hud_timer > 0) {
    hud_timer--;
} else {
    hud_visible = false;
}