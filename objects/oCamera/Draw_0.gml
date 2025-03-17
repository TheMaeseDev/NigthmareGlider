draw_self();

// Guardar el color y alpha actuales
var prevColor = draw_get_color();
var prevAlpha = draw_get_alpha();

// Establecer color negro con transparencia
draw_set_color(c_black);
draw_set_alpha(0.5); // 30% de transparencia

// Dibujar la deadzone
//draw_rectangle(camLeft, camTop, camRight, camBottom, false); // false = sin relleno

//draw_rectangle(oPlayer.x-50, oPlayer.y-50,oPlayer.x+50,oPlayer.y+50, false);  // true = con relleno

if global.showDebug{
	draw_rectangle(x1, y1, x2, y2, false); // false = sin relleno
}


// Restaurar color y alpha originales
draw_set_color(prevColor);
draw_set_alpha(prevAlpha);