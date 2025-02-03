
var _movement = object_movement(hsp,vsp,grv,face);
hsp=_movement[0];
vsp=_movement[1];



blink_effect(id);

//Frenar hsp al tocar el suelo
if place_meeting(x, y + vsp, oWall) || place_meeting(x, y + vsp, oSemiSolidWall) {
	hsp = hspDefault; // Detener Movimiento
}


#region Fuentes de daño

//Hitbox del player
if instance_place(x,y,oPlayer_Air_Attack_HB) || instance_place(x,y,oPlayer_Attack_HB){
	enemy_take_damage(self.id, 1, true, oPlayer.x, 180);
}

//Explosion de Bomba
if instance_place(x,y,oBomb_Explosion){
	enemy_take_damage(self.id, 3, true, oPlayer.x, 180);
}

//Smallbox
if instance_place(x+hsp*face,y,oSmallBox){
	enemy_take_damage(self.id, 3, true, oPlayer.x, 180);
}

#endregion