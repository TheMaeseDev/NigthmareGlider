
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
draw_sprite(sCollectable_Coin, 0, cam_x + padding, cam_y + padding); // Esquina superior izquierda
draw_sprite(sCollectable_Live, 0, cam_x + cam_w - icon_size - padding, cam_y + padding); // Esquina superior derecha
draw_sprite(sSpecialBox, 0, cam_x + padding + 5, cam_y + cam_h - padding + 3); // Esquina inferior izquierda
draw_sprite(sBomb, 0, cam_x + cam_w - icon_size - padding + 2, cam_y + cam_h - padding + 3); // Esquina inferior derecha

// Restaurar alpha normal
draw_set_alpha(1);

// Dibujar los números al lado de cada ícono
draw_set_color(c_white);
draw_text(cam_x + icon_size + 7, cam_y + padding, string(global.Player_Coins)); // Monedas
draw_text(cam_x + cam_w - icon_size - padding + 20, cam_y + padding, string(global.Player_Lives)); // Vidas
draw_text(cam_x + padding + icon_size + 5,  cam_y + cam_h - padding - 7, string(global.Room_SpecialBox_Broken)); // Cajas rotas
draw_text(cam_x + cam_w - icon_size - padding + 20, cam_y + cam_h - padding - 7, string(global.Player_Power)); // Power