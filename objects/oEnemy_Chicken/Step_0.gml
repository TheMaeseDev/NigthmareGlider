var _movement = object_movement(hsp,vsp,grv,face);
hsp=_movement[0];
vsp=_movement[1];

blink_effect(id);

//cambiar de direccion
//Voltear si se encuentra con una pared
if place_meeting(x+hsp, y, oWall){
	hsp = -hsp;
}

//Voltear si no encuentra camino
if !place_meeting(x+hsp, y + 1, oWall){
	hsp = -hsp;
}

//Voltear si alcanza su rango de X
var absLimit = abs(x-startX);
if absLimit>=xMoveRange{
	hsp = -hsp;
}

//Explosion de Bomba
var _collision = instance_place(x,y,oBomb_Explosion)
if instance_exists(_collision){
	enemy_take_damage(self.id, 3, knockback,5,3,_collision.x, 180);
}

//Cuando puede atacar
if canAttackTimer>0 canAttackTimer--;
if canAttackTimer <= 0{
	canAttack = true;
}

//Hitbox del player
if instance_place(x,y,oPlayer_Air_Attack_HB) || instance_place(x,y,oPlayer_Attack_HB){
	canAttack = false;
	if !invulnerable canAttackTimer = canAttackFrames;
	enemy_take_damage(self.id, 1, knockback,kbx,kby,oPlayer.x, 180);
}

if canAttack with instance_place(x,y,oPlayer) self.takeDamage(1,other.x);

//Smallbox
var _collision = instance_place(x,y,oSmallBox)
if instance_exists(_collision){
	enemy_take_damage(self.id, 1, knockback,kbx,kby,_collision.x, 180);
	with _collision Destroy();
}

#endregion

#region Enemy Death

if hp<=0 && state!="hurt"{
	enemyDestroy();	
}

#endregion

image_xscale = -sign(hsp);

if hsp!=0{
	sprite_index = sEnemy_Chicken_Run;	
}else{
	sprite_index = sEnemy_Chicken_Idle; image_xscale = 1;
}

