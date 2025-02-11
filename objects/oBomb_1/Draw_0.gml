draw_self();

#region Bomb Blink
// Verificar si la bomba está activada
if (timerStart) {
    // Calcular el tiempo restante en segundos (suponiendo 60 FPS)
    var _secondsLeft = timerFrames / 60;
    
    // Calcular la frecuencia de parpadeo (menos frecuencia al inicio, más al final)
    var _blinkInterval;
    
    if (_secondsLeft > 4) {
        _blinkInterval = 60; // Parpadea una vez por segundo
    } else if (_secondsLeft > 3) {
        _blinkInterval = 30; // Cada 0.5s
    } else if (_secondsLeft > 2) {
        _blinkInterval = 15; // Cada 0.25s
    } else if (_secondsLeft > 1) {
        _blinkInterval = 8; // Cada 0.13s
    } else {
        _blinkInterval = 4; // Muy rápido en el último segundo
    }
    
    // Parpadeo: Se activa cuando `timerFrames` es múltiplo de `blinkInterval`
    if (timerFrames mod _blinkInterval == 0) {
        gpu_set_blendmode(bm_add);
        draw_set_color(c_white);
        draw_sprite(sprite_index, image_index, x, y);
        gpu_set_blendmode(bm_normal);
    }
}

#endregion

// Configurar el color y la alineación del texto
//draw_set_color(c_white);  
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Dibujar el número de vida sobre el enemigo
if global.showDebug{
	draw_text(x, y-sprite_height*1.5, string(timerFrames/60) );
}