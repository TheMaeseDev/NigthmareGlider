
if (canMove){
    rol="activo";
	pairedPlatform.rol="pasivo";
	state = "isMoving"
}else{
	state="idle";
}


//Se mueve si el jugador la pisa
if canMove && rol=="activo"{
	
	//Si se encuentra en los limites
	if y+ysp<=bottomLimit{
		ysp+=grv;
	}else{
		ysp=0;
	}
}
/*
if !canMove && rol=="activo"{
	if y==0{
		ysp=0;
	}else{
		if(y>startY){
			ysp+=returnSpeed;
			if y<=startY+1{
				ysp=0;
				y=startY;
				
			}
		}
		if(y<startY){
			ysp-=returnSpeed;
			if y>=startY-1{
				ysp=0;
				y=startY;
			}
		}
	}
}*/

if !canMove && rol=="activo"{
	if(y>startY){
		ysp+=returnSpeed;
		if y+ysp<=startY+1{
			ysp=0;
			y=startY;
			pairedPlatform.y=y;
		}
	}
	if(y<startY){
		ysp-=returnSpeed;
		if y+ysp>=startY-1{
			ysp=0;
			y=startY;
			pairedPlatform.y=y;
		}
	}
}


y+=ysp;
pairedPlatform.ysp = -ysp;