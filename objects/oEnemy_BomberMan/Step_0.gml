var suelo_frente = place_meeting(x+3+hsp*face, y + 1, oWall);
var suelo_atras = place_meeting(x+hsp+2*-face,y+1,oWall);
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
		hsp=1;
		if (distance_to_object(oPlayer) < 125) state=EnemyState.Raway;
		break;
		
    case EnemyState.Raway:
		//Cambio de sprite
		sprite_index=sprWalk;
		
		face = sign(oPlayer.x - x)*-1;
		
		//Si el player esta lo suficientemente lejos cambia de estado
		if playerDistance>minPlayerDistance state=EnemyState.isAway;
		
		//Se mueve si hay suelo
		if suelo_frente{
			hsp=2;	
		}else state=EnemyState.Trapped;
	break;
	
	case EnemyState.isAway:
		face=sign(oPlayer.x - x)*1;
		
		if !suelo_atras state=EnemyState.Trapped;
		
		//Si el player esta muy cerca cambia de estado para alejarse
		// Si el jugador se acerca, intentar huir
	    if (playerDistance < minPlayerDistance && suelo_atras) {
	        // Solo cambiar de estado si el enemigo realmente tiene hacia dónde moverse
	        if (suelo_atras) {
	            state = EnemyState.Raway;
	        }
	    }
		
		if playerDistance>minPlayerDistance{
			face = sign(oPlayer.x - x)*1;
			hsp = 2;
		}
		
		hsp=0;
		sprite_index=sprIdle;
	break;
	
	case EnemyState.Trapped:
		hsp=0;
		sprite_index = sprIdle;
		face = sign(oPlayer.x - x)*1;
		
		if suelo_atras state=EnemyState.Raway;
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

global.mensaje = state;