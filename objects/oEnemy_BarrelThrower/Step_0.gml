var _movement = object_movement(hsp,vsp,grv,face);
hsp=_movement[0];
vsp=_movement[1];

blink_effect(id);

switch (barrelThroweState){
    case BarrelThrowerState.IDLE:
		canTakeDamage=true;
		sprite_index=sEnemy_BarrelThrower;
        bombThrowTimer--;
		punchTimer=punchFrames;
        if (bombThrowTimer <= 0) {
            barrelThroweState = BarrelThrowerState.THROWING;
            sprite_index = sEnemy_BarrelThrower_Punch;
            image_index = 0;
			barrelThrown=false;
        }
		if(distance_to_object(oPlayer)<50){
			barrelThroweState = BarrelThrowerState.PUNCHING;
		}
    break;

    case BarrelThrowerState.THROWING:
		canTakeDamage=true;
        if (image_index >= 3 && !barrelThrown) {
           throwBarrel();
		   barrelThrown=true;
        }

        if (image_index >= image_number - 1) { // Si la animación termina
            barrelThroweState = BarrelThrowerState.IDLE;
            bombThrowTimer = bombThrowFrames;
        }
    break;

    case BarrelThrowerState.PUNCHING:
		punchTimer--;
        if (distance_to_object(oPlayer) > 50) { // Si el jugador se aleja, vuelve a tirar barriles
            barrelThroweState = BarrelThrowerState.IDLE;
			bombThrowTimer=30;
			punchTimer=60;
        }
		
		if punchTimer<=0{
			sprite_index = sEnemy_BarrelThrower_Punch;
            canTakeDamage=false;
			if (image_index >= image_number - 1) {
	           punchTimer=punchFrames;
			   sprite_index = sEnemy_BarrelThrower;
			   canTakeDamage=true;
	        }
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
}
if canAttack with instance_place(x,y,oPlayer) self.takeDamage(1,other.x);
//Cuando puede atacar
if canAttackTimer>0 canAttackTimer--;
if canAttackTimer <= 0{
	canAttack = true;
}

if hp<=0 && state!="hurt"{
	enemyDestroy();	
}

image_xscale = face;

if instance_exists(oPlayer){
	if (x<oPlayer.x) face=1;
	if (x>oPlayer.x) face=-1;
}