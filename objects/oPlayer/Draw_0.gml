//Draw myself
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*face,image_yscale, image_angle,image_blend,image_alpha);

// Obtén las coordenadas y el tamaño de la vista de la cámara
var view_x = camera_get_view_x(view_camera[0]); // X de la cámara
var view_y = camera_get_view_y(view_camera[0]); // Y de la cámara
var view_w = camera_get_view_width(view_camera[0]); // Ancho de la cámara
var view_h = camera_get_view_height(view_camera[0]); // Altura de la cámara

// Calcula la posición centrada
var texto_x = view_x + view_w / 2;
var texto_y = view_y + view_h / 2;

// Dibuja el mensaje en el centro de la vista si no está vacío
if (global.mensaje != "") {
    draw_set_halign(fa_center); // Alineación horizontal centrada
    draw_set_valign(fa_middle); // Alineación vertical centrada
    draw_set_color(c_white); // Color del texto
    draw_text(texto_x, texto_y, global.mensaje); // Dibuja el texto en el centro
}