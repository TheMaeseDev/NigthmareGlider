
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

if !canMove && rol=="activo"{
	if(y>startY){
		yspd+=returnSpeed;
		if y+yspd<=startY+1{
			yspd=0;
			y=startY;
			pairedPlatform.y=y;
		}
	}
	if(y<startY){
		yspd-=returnSpeed;
		if y+yspd>=startY-1{
			yspd=0;
			y=startY;
			pairedPlatform.y=y;
		}
	}
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