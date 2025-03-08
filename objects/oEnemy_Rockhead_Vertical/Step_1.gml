mask_index = sprite_idle; // Siempre volver a Idle antes de hacer cambios

switch (state) {
	case "moving":
		// Aplicar aceleración
		yspd += accel * dirY;
		
		// Limitar velocidad
		yspd = clamp(yspd, -maxSpeed, maxSpeed);

		// Mover en pasos pequeños
		var steps = ceil(abs(yspd));
		for (var i = 0; i < steps; i++) {
			if (place_meeting(x, y + sign(yspd), oWall)) {
				// Cambiar sprite al chocar
				if (sign(yspd) > 0) {
					sprite_index = sprite_downHit; // Chocó contra el suelo
				} else {
					sprite_index = sprite_upHit; // Chocó contra el techo
				}
				image_speed = 1.5; // Reproducir animación
				image_index = 0;
				
				// Detener movimiento
				yspd = 0;
				accel = -accel; // Invertir dirección
				state = "hit";
				cameraShake(5, 2);
				break;
			} else {
				y += sign(yspd);
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
		if (restTimer <= 0) {
			state = "moving";
		}
	break;
}
