
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
				// Si hay colisión, detener y cambiar dirección
				xspd = 0; // Resetear velocidad para nueva aceleración
				accel = -accel; // Invertir aceleración para el otro sentido
				state = "rest";
				cameraShake(5, 2);
				break;
			} else {
				x += sign(xspd); // Mover un píxel en la dirección de la velocidad
			}
		}
		// Reiniciar el timer de descanso
		restTimer = restFrames;
	break;
	
	case "rest":
		restTimer--;
		if restTimer<=0{
			state="moving";	
		}
	break;
}

