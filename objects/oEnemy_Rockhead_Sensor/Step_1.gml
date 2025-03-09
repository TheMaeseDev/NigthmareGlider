mask_index = sprite_idle;

switch (state) {
	case "idle":
		// Si el jugador está dentro del rango, iniciar ataque
		var detectionRange = 200; // Distancia en la que detecta al jugador
		if (oPlayer.y > y && oPlayer.y < y + detectionRange && abs(oPlayer.x - x) < 18) {
			state = "attack";
			yspd = attackSpeed; // Velocidad rápida de ataque
		}
	break;

	case "attack":
		// Aplicar velocidad de ataque
		y += yspd;

		// Si choca contra el suelo, entra en estado "hit"
		if (place_meeting(x, y + 1, oWall)) {
			sprite_index = sprite_downHit;
			image_speed = 1.5;
			image_index = 0;
			yspd = 0;
			state = "hit";
			restTimer = restFrames;

			// Temblor de cámara si el jugador está cerca
			var shakeRadius = 100;
			if (distance_to_object(oPlayer) < shakeRadius) {
				cameraShake(5, 2);
			}
		}
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
		// Esperar un momento antes de regresar
		restTimer--;
		if (restTimer <= 0) {
			state = "return";
			yspd = 0; // Velocidad lenta de retorno
		}
	break;

	case "return":
		// Aplicar aceleración al retorno
		yspd -= accel;
		yspd = max(yspd, -maxSpeed); // Limitar la velocidad máxima

		// Mover con la velocidad calculada
		y += yspd;

		// Si llegó a la posición inicial, detener y volver a idle
		if (y <= startY) {
			y = startY;
			yspd = 0;
			state = "idle";
		}
	break;
}
