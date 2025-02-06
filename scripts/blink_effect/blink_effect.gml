/// blink_effect(_enemy)
function blink_effect(_enemy) {
    with (_enemy) {
        if (invulnerable) {
            if (blinkTimer > 0) {
                blinkTimer--;
				// Ajuste progresivo de la velocidad del parpadeo
				var _t = blinkTimer/maxBlinkTimer;
				
                // Calcular frecuencia de parpadeo (rápido al inicio, lento al final)
			    var _blinkSpeed = 1+(_t*2); //Mas alto el numero '8, mas dura la fase rapida.
				if _blinkSpeed > 0.5{
					image_alpha = (floor(blinkTimer/_blinkSpeed) mod 2); // Alterna entre 0 y 1
				}
            } else {
                invulnerable = false;
                image_alpha = 1; // Restaurar visibilidad
            }
        }
    }
}