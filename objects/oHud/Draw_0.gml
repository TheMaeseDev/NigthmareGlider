
#region Primary Sets

// Obtener tamaño de la pantalla
var cam_x = camera_get_view_x(view_camera[0]);
var cam_y = camera_get_view_y(view_camera[0]);
var cam_w = camera_get_view_width(view_camera[0]);
var cam_h = camera_get_view_height(view_camera[0]);

// Tamaño de los iconos
var icon_size = 32;
var padding = 20; // Margen desde los bordes

// Configurar transparencia
draw_set_alpha(1);

#endregion

#region Definir arrays para posiciones
var hud_x = array_create(6, 0);
var hud_final_y = array_create(6, 0);
var hud_start_y = array_create(6, 0);

#endregion

#region Calcular Posicion Final de Cada elemento
// Monedas (Top Left)
hud_x[0] = cam_x + padding;
hud_final_y[0] = cam_y + padding;

// Vidas (Top Right)
hud_x[1] = cam_x + cam_w - icon_size - padding;    
hud_final_y[1] = cam_y + padding;

// Cajas (Bottom Left)
hud_x[2] = cam_x + padding + 5;                    
hud_final_y[2] = cam_y + cam_h - padding + 3;

// Power (Bottom Right)
hud_x[3] = cam_x + cam_w - icon_size - padding + 2; 
hud_final_y[3] = cam_y + cam_h - padding + 3;

// Health Bar
hud_x[4] = cam_x + (cam_w / 2);
hud_final_y[4] = cam_y + 10 + sprite_get_height(sHealthBar) / 2;

// Map Pieces
hud_x[5] = cam_x + (cam_w / 2) - 46;
hud_final_y[5] = cam_y + cam_h - 27;

#endregion

#region Calcular Posicion Inicial de Cada elemento (Lugar escondidos)

hud_start_y[0] = hud_final_y[0] - 50;
hud_start_y[1] = hud_final_y[1] - 50;
hud_start_y[2] = hud_final_y[2] + 50;
hud_start_y[3] = hud_final_y[3] + 50;
hud_start_y[4] = hud_final_y[4] - 50;
hud_start_y[5] = hud_final_y[5] + 50;

#endregion

#region Dibujar los íconos

draw_sprite_ext(sCollectable_Coin, 0, hud_x[0], hud_final_y[0], 1.5, 1.5, 0, c_white, 1); // Esquina superior izquierda
draw_sprite(sCollectable_Live, 0, hud_x[1], hud_final_y[1]); // Esquina superior derecha
draw_sprite(sSpecialBox, 0, hud_x[2], hud_final_y[2]); // Esquina inferior izquierda
draw_sprite(sBomb, 0, hud_x[3], hud_final_y[3]); // Esquina inferior derecha
draw_sprite(sHealthBar, global.Player_Hp, hud_x[4], hud_final_y[4]); //Arriba Centro

// Si la animación terminó, dibujar el mapa completo y salir
if (map_merge_progress == 1) {
    draw_sprite(sCollectable_Map, 0, cam_x + (cam_w / 2), hud_final_y[5]);
    exit; // Termina la función aquí para no dibujar los fragmentos
}

// Dibujar fragmentos del mapa con animación de movimiento al centro
for (var i = 0; i < 4; i++) {
    if (global.Room_MapPieces[i]) { 
        var start_x = hud_x[5] + (i * 32); // Posición inicial de cada fragmento
        var target_x = cam_x + (cam_w / 2); // Centro del HUD
        var interp_x = lerp(start_x, target_x, map_merge_progress); // Interpolación suave

        draw_sprite_ext(map_sprites[i], 0, interp_x, hud_final_y[5], 1, 1, 0, c_white, 1);
    }
}

#endregion

#region Dibujar los números al lado de cada ícono

draw_set_color(c_white);
draw_text(hud_x[0]+25, hud_final_y[0], string(global.Player_Coins)); // Monedas
draw_text(hud_x[1]+25, hud_final_y[1], string(global.Player_Lives)); // Vidas
draw_text(hud_x[2]+30, hud_final_y[2]-10, string(global.Room_SpecialBox_inRoom - global.Room_SpecialBox_Broken)); // Cajas rotas
draw_text(hud_x[3]+20, hud_final_y[3]-10, string(global.Player_Power)); // Power

#endregion

