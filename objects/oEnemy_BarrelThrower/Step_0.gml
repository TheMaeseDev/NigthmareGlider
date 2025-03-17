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
		if instance_exists(golpe) instance_destroy(golpe);
        if (bombThrowTimer <= 0) {
            barrelThroweState = BarrelThrowerState.THROWING;
            sprite_index = sEnemy_BarrelThrower_Barrel;
            image_index = 0;
			barrelThrown=false;
        }
		if(abs(x - oPlayer.x) <= 40){
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
		bombThrowTimer=bombThrowFrames;
        if (abs(x - oPlayer.x) > 40) && !punching{ // Si el jugador se aleja, vuelve a tirar barriles
            barrelThroweState = BarrelThrowerState.IDLE;
			bombThrowTimer=30;
			punchTimer=60;
        }
		
		if punchTimer<=0{
			sprite_index = sEnemy_BarrelThrower_Barrel;
			punching=true;
			if (image_index >= 3 && !alreadyPunch) {
				golpe = instance_create_depth(x+30*face,y,depth,oEnemy_Hitbox);
				golpe.image_yscale*=3;
				alreadyPunch=true;
			}
			if (image_index >= image_number - 1){
				instance_destroy(golpe);
				punchTimer=punchFrames;
				sprite_index = sEnemy_BarrelThrower;
				alreadyPunch=false;
				punching=false;
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

image_xscale = 0.75*face;
image_yscale = 0.75;

if instance_exists(oPlayer){
	if (x<oPlayer.x) face=1;
	if (x>oPlayer.x) face=-1;
}