
switch (state) {
	case "moving":
		// Aplicar aceleración en la dirección actual
		xspd += accel * dirX;
		yspd += accel * dirY;

		// Limitar la velocidad máxima
		xspd = clamp(xspd, -maxSpeed, maxSpeed);
		yspd = clamp(yspd, -maxSpeed, maxSpeed);

		// Mover en pasos pequeños para no atravesar paredes
		var steps = ceil(max(abs(xspd), abs(yspd))); 
		for (var i = 0; i < steps; i++) {
			if (place_meeting(x + sign(xspd), y + sign(yspd), oWall)) {
				// Si colisiona, detenerse y cambiar de dirección
				xspd = 0;
				yspd = 0;
				state = "rest";
				cameraShake(5, 2);
				changeDirection();
				break;
			} else {
				x += sign(xspd);
				y += sign(yspd);
			}
		}

		// Reiniciar el timer de descanso
		restTimer = restFrames;
	break;

	case "rest":
		restTimer--;
		if (restTimer <= 0) {
			state = "moving";
		}
	break;
}

