
var _movement = object_movement(hsp,vsp,grv,face);
hsp=_movement[0];
vsp=_movement[1];

blink_effect(id);

//Frenar hsp al tocar el suelo
if place_meeting(x, y + vsp, oWall) || place_meeting(x, y + vsp, oSemiSolidWall) {
	hsp = hspDefault; // Detener Movimiento
}

#region Fuentes de daño

//Cuando puede atacar
if canAttackTimer>0 canAttackTimer--;
if canAttackTimer <= 0{
	canAttack = true;
}

//Hitbox del player
if instance_place(x,y,oPlayer_Air_Attack_HB) || instance_place(x,y,oPlayer_Attack_HB){
	canAttack = false;
	if !invulnerable canAttackTimer = canAttackFrames;
	enemy_take_damage(self.id, 1, true,3,3,oPlayer.x, 180);
}

if canAttack with instance_place(x,y,oPlayer) self.takeDamage(1,other.x);

//Explosion de Bomba
var _collision = instance_place(x,y,oBomb_Explosion)
if instance_exists(_collision){
	enemy_take_damage(self.id, 3, true,5,3,_collision.x, 180);
}

//Smallbox
var _collision = instance_place(x,y,oSmallBox)
if instance_exists(_collision){
	enemy_take_damage(self.id, 3, true,5,3,_collision.x, 180);
}

#endregion

global.mensaje = canAttackTimer;

#region Enemy Death

if hp<=0 && (place_meeting(x, y + vsp, oWall) || place_meeting(x, y + vsp, oSemiSolidWall)) enemyDestroy();

#endregion