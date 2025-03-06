
var _movement = object_movement(hsp,vsp,grv,face);
hsp=_movement[0];
vsp=_movement[1];

blink_effect(id);

switch (state) {
    case ErizoState.Rolling:
		canTakeDamage=false;
        hsp = roll_speed * face;
		sprite_index=sEnemy_Patricio_Spin;
        // Si detecta el borde o una pared, cambiar a Stopped
        if (!place_meeting(x + face * 4, y + 1, oWall) || place_meeting(x + face * 4, y, oWall)) {
            state = ErizoState.Stopped;
            hsp = 0;
            stopped_timer = stopped_frames; // Espera 30 frames
        }
    break;

    case ErizoState.Stopped:
		canTakeDamage=true;
		sprite_index=sEnemy_Patricio_Idle;
        stopped_timer--;
        if (stopped_timer <= 0) {
            face *= -1; // Invertir dirección
            state = ErizoState.Rolling;
        }
    break;

    case ErizoState.Idle:
		canTakeDamage=true;
		face=1*sign(x-oPlayer.x);
		sprite_index=sEnemy_Patricio_Idle;
        jump_timer--;
        if (jump_timer <= 0) {
            if is_jumper{
				vsp=jump_power;
				state=ErizoState.Jumping;
			}else if is_jump_attacker{
				vsp = jump_attack_vsp;
				if needToReturn hsp = -jump_attack_hsp;
	            else hsp = jump_attack_hsp;
				state=ErizoState.JumpAttack;
			}
        }
    break;

    case ErizoState.Jumping:
		canTakeDamage=false;
		sprite_index=sEnemy_Patricio_Spin;
        if (place_meeting(x, y + 1, oWall)) {
            state = ErizoState.Idle;
            jump_timer = stopped_frames;
        }
    break;
	
	case ErizoState.JumpAttack:
		canTakeDamage=false;
		sprite_index=sEnemy_Patricio_Spin;
        if (place_meeting(x, y + 1, oWall)) {
			horJumpsCount--;
			//Si ya hizo todos los saltos
			if(horJumpsCount<=0){
				if needToReturn{
					//Si ya volvio, resetear estado
					state=ErizoState.Idle;
					needToReturn=false;
					horJumpsCount = horJumpsFrames;
					hsp=0;
				}
				else{
					needToReturn=true;
					horJumpsCount=horJumpsFrames;
				}
			}
            state = ErizoState.Idle;
            jump_timer = 45;
            hsp = 0; // Se detiene antes de volver a saltar
        }
    break;
	
	case ErizoState.Hit:
		sprite_index = sEnemy_Patricio_Hit;
		if(image_index >= image_number-1){
			if is_roller state=ErizoState.Stopped;
			else state=ErizoState.Idle;
		}
	break;
}

//Si puede recibir daño ejecuta el script
if canTakeDamage{
	//Hitbox del player
	if instance_place(x,y,oPlayer_Air_Attack_HB) || instance_place(x,y,oPlayer_Attack_HB){
		canAttack = false;
		if !invulnerable canAttackTimer = canAttackFrames;
		enemy_take_damage(self.id, 1, knockback,kbx,kby,oPlayer.x, 180);
		state=ErizoState.Hit;
	}
	//Smallbox
	var _collision = instance_place(x,y,oSmallBox)
	if instance_exists(_collision){
		enemy_take_damage(self.id, 1, knockback,kbx,kby,_collision.x, 180);
		state=ErizoState.Hit;
		with _collision Destroy();
	}
	
	if instance_place(x,y,oBomb_Explosion){
		enemy_take_damage(self.id, 3, knockback,5,3,x, 180);
	}
}
image_xscale = face;

if canAttack with instance_place(x,y,oPlayer) self.takeDamage(1,other.x);
//Cuando puede atacar
if canAttackTimer>0 canAttackTimer--;
if canAttackTimer <= 0{
	canAttack = true;
}

if hp<=0 && state!="hurt"{
	enemyDestroy();	
}