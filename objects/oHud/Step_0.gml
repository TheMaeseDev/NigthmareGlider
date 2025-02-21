
// Si se tienen los 4 fragmentos y aún no se ha completado la animación
if (global.Room_MapPieces[0] && global.Room_MapPieces[1] && global.Room_MapPieces[2] && global.Room_MapPieces[3]) {
    if (map_merge_progress < 1) {
        map_merge_progress += map_animation_speed;
        if (map_merge_progress > 1) {
            map_merge_progress = 1; // Limitar el progreso a 1
        }
    }
}

hudKey = keyboard_check_pressed(vk_tab) + gamepad_button_check_pressed(0,gp_shoulderlb);
hudKey = clamp(hudKey,0,1);

if hudKey show=!show;