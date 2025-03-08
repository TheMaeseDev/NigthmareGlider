mask_index = sprite_idle;

switch (state){
	case "moving":
		// Aplicar aceleracion
		xspd += accel * dirX;
		
		// Limitar la velocidad máxima
		xspd = clamp(xspd, -maxSpeed, maxSpeed);

		// Mover en pasos pequeños para no atravesar la pared
		var steps = ceil(abs(xspd)); // Determina cuántos pasos dividir el movimiento
		for (var i = 0; i < steps; i++) {
			if (place_meeting(x+sign(xspd), y, oWall)) {
				// Cambiar sprite al chocar
				if (sign(xspd) > 0) {
					sprite_index = sprite_right_hit; // Chocó contra la derecha
				} else {
					sprite_index = sprite_left_hit; // Chocó contra la izquierda
				}
				image_speed = 1.5; // Reproducir animación
				image_index = 0;
				
				
				// Si hay colisión, detener y cambiar dirección
				xspd = 0; // Resetear velocidad para nueva aceleración
				accel = -accel; // Invertir aceleración para el otro sentido
				state = "hit";
				cameraShake(5, 2);
				break;
			} else {
				x += sign(xspd); // Mover un píxel en la dirección de la velocidad
			}
		}
		// Reiniciar el timer de descanso
		restTimer = restFrames;
	break;
	
	case "hit":
		// Esperar a que termine la animación para volver a Idle
		if (image_index >= image_number - 1) {
			sprite_index = sprite_idle;
			image_speed = 0;
			image_index = 0;
			state = "rest";
		}
	break;
	
	case "rest":
		restTimer--;
		if restTimer<=0{
			state="moving";	
		}
	break;
}

