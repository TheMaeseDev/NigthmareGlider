var suelo_frente = place_meeting(x+3*face, y + 1, oWall);
var suelo_atras = place_meeting(x+3*-face,y+1,oWall);
var suelo_abajo = place_meeting(x, y + 1, oWall);
var playerDistance = abs(oPlayer.x - x);

switch (state) {
    case EnemyState.Idle:
		sprite_index = sprIdle;
		if(image_index >= image_number-1){
			state = EnemyState.Walk;	
		}
		hsp=0;
		
		if (distance_to_object(oPlayer) < 125) state=EnemyState.Raway;
        break;
		
	case EnemyState.Walk:
		sprite_index = sprWalk;
		if initialDistance<=abs(x-xStart) || !suelo_frente{
			face=-face;
			state = EnemyState.Idle;
		}
		hsp=1*face;
		if (distance_to_object(oPlayer) < 125) state=EnemyState.Raway;
		break;
		
    case EnemyState.Raway:
		//Cambio de sprite
		sprite_index=sprWalk;
		
		//Mirar en direccion opuesta al player
		face = -sign(oPlayer.x - x);
		
		//Si el player esta lo suficientemente lejos cambia de estado
		if playerDistance>minPlayerDistance hsp=0;
		else{
			//Se mueve si hay suelo
			if suelo_frente{
				hsp=1*face;	
			}else state=EnemyState.Trapped;
		}
		
		
	break;
	
	case EnemyState.isAway:
		hsp=0;
		sprite_index=sprIdle;
		//Mira en direccion del player
		face=sign(oPlayer.x - x)*1;
		
		if !suelo_atras state=EnemyState.Trapped;
		
		// Si el jugador se acerca, intentar huir
	    if (playerDistance < minPlayerDistance && suelo_atras) {
	        state = EnemyState.Raway;
	    }
		/*
		if playerDistance>minPlayerDistance{
			face = sign(oPlayer.x - x)*1;
			hsp = 2*face;
		}*/
		
		
	break;
	
	case EnemyState.Trapped:
		hsp=0;
		face = sign(oPlayer.x - x)*1;
		sprite_index = sprIdle;
		
		//if suelo_atras state=EnemyState.Raway;
	case EnemyState.Attack:
		
	break;
}

/*
BombTimer--;
if BombTimer<=0{
	throwBomb(4.5*-face,-4.5)	
	BombTimer=180;
}*/

var _movement = object_movement(hsp,vsp,grv,face);
hsp = _movement[0];
vsp = _movement[1];

//global.mensaje = "SA: "+string(suelo_atras);
global.mensaje = face;