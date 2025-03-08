mask_index = sprite_idle;

switch (state) {
	case "moving":
		// Aplicar aceleración
		xspd += accel * dirX;
		yspd += accel * dirY;

		// Limitar velocidad
		xspd = clamp(xspd, -maxSpeed, maxSpeed);
		yspd = clamp(yspd, -maxSpeed, maxSpeed);

		// Mover en pasos pequeños
		var steps = ceil(max(abs(xspd), abs(yspd)));
		for (var i = 0; i < steps; i++) {
			if (place_meeting(x + sign(xspd), y + sign(yspd), oWall)) {
				// Si colisiona, cambiar de sprite según la dirección
				changeSprite();
				
				changeDirection();
				
				// Detener movimiento
				xspd = 0;
				yspd = 0;
				state = "hit";
				cameraShake(5, 2);
				break;
			} else {
				x += sign(xspd);
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

