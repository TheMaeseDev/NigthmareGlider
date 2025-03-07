
switch (state){
	case "moving":
		// Aplicar aceleracion
		yspd += accel * dirY;
		
		// Limitar la velocidad máxima
		yspd = clamp(yspd, -maxSpeed, maxSpeed);

		// Mover en pasos pequeños para no atravesar la pared
		var steps = ceil(abs(yspd)); // Determina cuántos pasos dividir el movimiento
		for (var i = 0; i < steps; i++) {
			if (place_meeting(x, y + sign(yspd), oWall)) {
				// Si hay colisión, detener y cambiar dirección
				yspd = 0; // Resetear velocidad para nueva aceleración
				accel = -accel; // Invertir aceleración para el otro sentido
				state = "rest";
				cameraShake(5, 2);
				break;
			} else {
				y += sign(yspd); // Mover un píxel en la dirección de la velocidad
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


//Aplicar aceleracion
/*yspd += yAcc;
xspd += xAcc;*/

