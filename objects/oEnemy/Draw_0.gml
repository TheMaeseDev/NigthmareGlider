draw_self();

// Configurar el color y la alineación del texto
draw_set_color(c_white);  
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Dibujar el número de vida sobre el enemigo
draw_text(x+sprite_width/2, y, string(healthPts));