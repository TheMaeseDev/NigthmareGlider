if place_meeting(x,y,oPlayer){
	switch windDirection{
		case windDirections.Up:
			with oPlayer{
				if glideStart{
					yspd -= 0.3; // Empuja hacia arriba (ajusta la fuerza según necesites)
		            yspd = max(yspd, -4); // Limita la velocidad máxima ascendente
				}
				else{
					yspd*=0.9;
				}
			}
		break;
		
		case windDirections.Right:
			with oPlayer{
				x += 1.5; // Empuja hacia arriba (ajusta la fuerza según necesites)
			}
		break;
		
		case windDirections.Left:
			with oPlayer{
				x -= 1.5; // Empuja hacia arriba (ajusta la fuerza según necesites)
			}
		break;
	}
}