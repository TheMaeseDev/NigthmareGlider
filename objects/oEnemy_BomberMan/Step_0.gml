var suelo_frente = place_meeting(x+3*face, y + 1, oWall);
var suelo_atras = place_meeting(x+3*-face,y+1,oWall);
var suelo_abajo = place_meeting(x, y + 1, oWall);
var playerDistance = abs(oPlayer.x - x);
var PlayerIsNear = playerDistance<=minPlayerDistance;

switch (state) {
    case EnemyState.Idle:
		//sprite_index = sprIdle;
		if(image_index >= image_number-1){
			state = EnemyState.Walk;	
		}
		hsp=0;
		
		if (distance_to_object(oPlayer) < 120) state=EnemyState.Raway;
        break;
		
	case EnemyState.Walk:
		//sprite_index = sprWalk;
		if initialDistance<=abs(x-xStart) || !suelo_frente{
			face=-face;
			state = EnemyState.Idle;
		}
		hsp=1*face;
		if (distance_to_object(oPlayer) < 120) state=EnemyState.Raway;
		break;
		
    case EnemyState.Raway:
        sprite_index = sprWalk;
        
        // Se aleja del jugador
        face = sign(oPlayer.x - x) * -1; 
        hsp = 1 * face; 
        
        // Si no hay suelo atrás, pasa a "Acorralado"
        if (!suelo_frente){
            state = EnemyState.Trapped;
        }
		
        // Si se alejó lo suficiente, pasa a "Distanciado"
        else if (playerDistance > minPlayerDistance) {
            state = EnemyState.isAway;
        }
        break;

    case EnemyState.isAway:
        sprite_index = sprIdle;
        hsp = 0;
        
        // Mirar al jugador
        face = sign(oPlayer.x - x);
        
        // Si el jugador se acerca de nuevo y hay suelo atrás, volver a "Huyendo"
        if (playerDistance < minPlayerDistance && suelo_atras) {
            state = EnemyState.Raway;
        }
        break;

    case EnemyState.Trapped:
        sprite_index = sprIdle;
        hsp = 0;
        
        // Se queda en el borde mirando al jugador
        face = sign(oPlayer.x - x);
        
        // Si el jugador se aleja, cambiar a "Distanciado"
        if (playerDistance > minPlayerDistance) {
            state = EnemyState.isAway;
        }
        break;
	
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
global.mensaje = playerDistance<=minPlayerDistance;