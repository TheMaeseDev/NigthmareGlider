
// Obtener tamaño de la pantalla
var cam_x = camera_get_view_x(view_camera[0]);
var cam_y = camera_get_view_y(view_camera[0]);
var cam_w = camera_get_view_width(view_camera[0]);
var cam_h = camera_get_view_height(view_camera[0]);

// Tamaño de los iconos
var icon_size = 32;
var padding = 20; // Margen desde los bordes

// Configurar transparencia
draw_set_alpha(transparencia);

// Dibujar los íconos en las cuatro esquinas
draw_sprite_ext(sCollectable_Coin, 0, cam_x + padding, cam_y + padding, 1.5, 1.5, 0, c_white, 1); // Esquina superior izquierda
draw_sprite(sCollectable_Live, 0, cam_x + cam_w - icon_size - padding, cam_y + padding); // Esquina superior derecha
draw_sprite(sSpecialBox, 0, cam_x + padding + 5, cam_y + cam_h - padding + 3); // Esquina inferior izquierda
draw_sprite(sBomb, 0, cam_x + cam_w - icon_size - padding + 2, cam_y + cam_h - padding + 3); // Esquina inferior derecha

//Obtener posicion para la barra de vida
var bar_x = cam_x + (cam_w / 2) /*+ sHealthBar.sprite_width/2*/; // Centrar la barra de vida
//var bar_y = cam_y + 10 + sHealthBar.sprite_height/2; // Posición arriba
if (sprite_exists(sHealthBar)) {
    var bar_y = cam_y + 10 + sprite_get_height(sHealthBar) / 2;
} else {
    show_debug_message("Error: sHealthBar no está cargado en este Room.");
}

// Dibujar la barra de vida con la subimagen correspondiente
draw_sprite(sHealthBar, global.Player_Hp, bar_x, bar_y);

// Restaurar alpha normal
draw_set_alpha(1);

// Dibujar los números al lado de cada ícono
draw_set_color(c_white);
draw_text(cam_x + icon_size + 7, cam_y + padding - 8, string(global.Player_Coins)); // Monedas
draw_text(cam_x + cam_w - icon_size - padding + 20, cam_y + padding - 8, string(global.Player_Lives)); // Vidas
draw_text(cam_x + padding + icon_size -4,  cam_y + cam_h - padding - 15, string(global.Room_SpecialBox_inRoom - global.Room_SpecialBox_Broken)); // Cajas rotas
draw_text(cam_x + cam_w - icon_size - padding + 20, cam_y + cam_h - padding - 15, string(global.Player_Power)); // Power


// Posición del HUD (abajo en el centro)
var hud_x = cam_x + (cam_w / 2) - 46; // Centrado
var hud_y = cam_y + cam_h - 27;       // Un poco arriba del bordela

// Si la animación terminó, dibujar el mapa completo y salir
if (map_merge_progress == 1) {
    draw_sprite(sCollectable_Map, 0, cam_x + (cam_w / 2), hud_y);
    exit; // Termina la función aquí para no dibujar los fragmentos
}

// Dibujar fragmentos del mapa con animación de movimiento al centro
for (var i = 0; i < 4; i++) {
    if (global.Room_MapPieces[i]) { 
        var start_x = hud_x + (i * 32); // Posición inicial de cada fragmento
        var target_x = cam_x + (cam_w / 2); // Centro del HUD
        var interp_x = lerp(start_x, target_x, map_merge_progress); // Interpolación suave

        draw_sprite_ext(map_sprites[i], 0, interp_x, hud_y, 1, 1, 0, c_white, 1);
    }
}


