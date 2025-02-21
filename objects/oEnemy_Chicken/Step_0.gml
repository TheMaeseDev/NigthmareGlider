event_inherited();

//Voltear si se encuentra con una pared
if place_meeting(x+hsp, y, oWall){
	hsp = -hsp;
	lookDir = -lookDir;
}

//Voltear si no encuentra camino
if !place_meeting(x+hsp, y + 1, oWall){
	hsp = -hsp;
	lookDir = -lookDir;
}

//Voltear si alcanza su rango de X
var absLimit = abs(x-startX);
if absLimit>=xMoveRange{
	hsp = -hsp;
	lookDir = -lookDir;
}

//Explosion de Bomba
var _collision = instance_place(x,y,oBomb_Explosion)
if instance_exists(_collision){
	enemy_take_damage(self.id, 3, knockback,5,3,_collision.x, 180);
}

image_xscale = -lookDir;

if hsp!=0{
	sprite_index = sEnemy_Chicken_Run;	
}

