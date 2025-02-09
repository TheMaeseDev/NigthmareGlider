
if (canMove){
    rol="activo";
	pairedPlatform.rol="pasivo";
	state = "isMoving"
}else{
	state="idle";
}

//Se mueve si el jugador la pisa
if canMove && rol=="activo"{
	yspd+=grv;
}

if (!canMove && rol == "activo") {
    var dist = startY - y; // Distancia a la posición de reposo
    yspd = lerp(yspd, sign(dist) * min(abs(dist) * 0.05, returnSpeed), 0.015);
}

//Si se encuentra en los limites
if y+yspd>=bottomLimit{
	yspd=0;
	y=bottomLimit;
	pairedPlatform.y=topLimit;
}

//Limitar velocidades
yspd = clamp(yspd, maxFallSpd, maxUpSpd);

y+=yspd;
pairedPlatform.yspd = -yspd;