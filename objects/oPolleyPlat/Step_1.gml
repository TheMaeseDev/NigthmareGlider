
if (canMove) {
    ysp = lerp(ysp, speedMax, acceleration); // Aceleración progresiva
	pairedPlatform.ysp = -ysp; //Mover la otra plataforma
}else{
    ysp = lerp(ysp, 0, acceleration);
    pairedPlatform.ysp = -ysp;
}


// Si llega al límite, detener ambas plataformas
if (y + ysp >= bottomLimit) /*|| (y + ysp <= topLimit)*/ {
	while !y+sign(ysp)>= bottomLimit{
		y += sign(ysp);	
	}
    ysp = 0;
    speedMax = 0;
	pairedPlatform.y = topLimit;
    pairedPlatform.ysp = 0;
    pairedPlatform.speedMax = 0;
} else {
	y+=ysp;
    speedMax = 2;
    pairedPlatform.speedMax = 2;
}

if pairedPlatform.y == topLimit y=bottomLimit-0.001;

//Retornar a la posicion inicial
if polleyAttached.returnToRest && !canMove && !pairedPlatform.canMove{
	
}



