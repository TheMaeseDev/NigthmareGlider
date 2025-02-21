event_inherited();

var playerDistance = abs(oPlayer.x - x);
var suelo_frente = place_meeting(x+hsp,y+1,oWall);

switch (state) {
    case EnemyState.Idle:
		sprite_index = sprIdle;
		if(image_index >= image_number-1){
			state = EnemyState.Walk;	
		}
		hsp=0;
		lookDirection=face;
		
		if (distance_to_object(oPlayer) < 175) state=EnemyState.Angry;
	break;
		
	case EnemyState.Walk:
		sprite_index = sprWalk;
		if initialDistance<=abs(x-xStart) || !suelo_frente{
			face=-face;
			state = EnemyState.Idle;
		}
		hsp=1*face;
		if (distance_to_object(oPlayer) < 175) state=EnemyState.Angry;
	break;
		
    case EnemyState.Angry:
		prepareBomb(); //Funcion que prepara y tira la bomba
	    // Determinar dirección
		if (playerDistance <= minPlayerDistance) {
			sprite_index = sprWalk;
		    // El enemigo se aleja del player
		    face = (x < oPlayer.x) ? -1 : 1;
		    //hsp = runSpeed * face; // Corre en sentido opuesto al jugador
			
			// Si el player está a menos de la mitad de la distancia mínima, corre más rápido
		    if (playerDistance <= minPlayerDistance / 2) {
		        hsp = runSpeed2 * face; 
		    } else {
		        hsp = runSpeed * face; 
		    }
			lookDirection = -sign(oPlayer.x - x);
		} 
		else if (playerDistance > minPlayerDistance + 25) {
			sprite_index = sprWalk;
		    // El enemigo persigue al player
		    face = (x < oPlayer.x) ? 1 : -1;
		    hsp = runSpeed * face;
			lookDirection = sign(oPlayer.x - x);
		} 
		else {
			sprite_index = sprIdle;
		    hsp = 0; // Se detiene
			lookDirection = sign(oPlayer.x - x);
		}

		// Comprobar bordes
		if (!place_meeting(x + hsp, y+1, oWall)) {
		    hsp = 0; // Detenerse en el borde
			lookDirection = sign(oPlayer.x - x);
			if(sprite_index == sprWalk) sprite_index = sprIdle;
		}
		
		if (place_meeting(x + hsp, y, oWall)) {
		    hsp = 0; // Detenerse en el borde
			lookDirection = sign(oPlayer.x - x);
			if(sprite_index == sprWalk) sprite_index = sprIdle;
		}
		
		// Si el player se aleja demasiado, cambiar a Idle
	    if (playerDistance > maxPlayerDistance) {
	        state = EnemyState.Back;
	        hsp = 0;
	    }
    break;
	
	case EnemyState.Back:
		BombTimer=bombFrames;
		sprite_index = sprWalk;
		// Determinar la dirección en la que debe moverse
	    var nueva_face = sign(xStart - x);
	    if (nueva_face != 0) {
	        face = nueva_face;
	    }
		// Moverse hacia la posición inicial
		hsp = runSpeed/2 * face;
		lookDirection = face;
		
		// Si llega a su posición inicial, vuelve a Idle
	    if (abs(x - xStart) < 1) {
	        x = xStart; // Asegurar que no oscile
	        hsp = 0;
	        state = EnemyState.Idle;
	    }
		if (distance_to_object(oPlayer) < 175) state=EnemyState.Angry;
		
	break;
	
	case EnemyState.Attack:
		sprite_index = sprAttack;
		hsp=0;
		if(image_index >= image_number-1){
			state = EnemyState.Angry;	
		}
	break;
}

//Explosion de Bomba
var _collision = instance_place(x,y,oBomb_Explosion)
if instance_exists(_collision){
	enemy_take_damage(self.id, 1, knockback,0,3,_collision.x, 180);
}

//Modificar la velocidad de la bomba segun la cercania con el player
var dist = point_distance(x, y, oPlayer.x, oPlayer.y);
var maxDist = minPlayerDistance; // Distancia máxima para la velocidad más alta

// Escalar la velocidad según la distancia
bombHsp = 0.5 + ((6 - 0.5) * clamp(dist / maxDist, 0, 1));