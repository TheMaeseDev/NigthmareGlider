draw_self();

image_xscale = -face;

// Configurar el color y la alineación del texto
draw_set_color(c_white);  
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Dibujar el número de vida sobre el enemigo
if global.showDebug{
	draw_text(x, y-sprite_height*1.5, string(hp));
}