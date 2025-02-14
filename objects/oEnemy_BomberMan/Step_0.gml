var suelo_frente = place_meeting(x + hsp + 1*face, y + 1, oWall);
var suelo_abajo = place_meeting(x, y + 1, oWall);
var playerDistance = abs(oPlayer.x < x);

switch (state) {
    case EnemyState.Idle:
		sprite_index = sprIdle;
		if(image_index >= image_number-1){
			state = EnemyState.Walk;	
		}
		hsp=0;
        break;
		
	case EnemyState.Walk:
		sprite_index = sprWalk;
		if initialDistance<=abs(x-xStart) || !suelo_frente{
			face=-face;
			state = EnemyState.Idle;
		}
		hsp=1;
		break;
		
    case EnemyState.Raway:
		sprite_index=sprWalk;
		if playerDistance<minPlayerDistance{
			face = sign(oPlayer.x - x)*-1;
		}
		if suelo_frente hsp=1;
		else hsp=0;
	break;
	
	case EnemyState.isAway:
		
	break;
}

BombTimer--;
if BombTimer<=0{
	throwBomb(4.5*-face,-4.5)	
	BombTimer=180;
}

var _movement = object_movement(hsp,vsp,grv,face);
hsp = _movement[0];
vsp = _movement[1];

//global.mensaje = suelo_frente;