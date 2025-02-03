
#region Shooting Sistem and Sprite Control
/// Estados del cañón
switch(state) {
    case "idle":
        sprite_index = sEnemy_Cannon;
        image_index = 0;
        hasShoot = false;
        shootTimer--;
		shootMinDelay--;
		
		// Esperar a que la bomba explote antes de reiniciar el disparo
        if ( !instance_exists(bombInstance) ) && ( shootMinDelay <= 0 ) shootTimer=0;
        
        if (shootTimer <= 0) {
            shootTimer = shootFrames;
            state = "firing"; // Cambiar a animación de disparo
            sprite_index = sEnemy_Cannon_Fire;
            image_index = 0;
            //image_speed = 1; // Iniciar animación de disparo
        }
        break;

    case "firing":
        // Detectar si el cañón está en el frame exacto de disparo
        if (floor(image_index) == frameToShoot) && !hasShoot {
            fireBomb(); // Disparar bomba
        }
		shootMinDelay = 90;
        // Si la animación terminó, volver a idle
        if (image_index >= image_number - 1) {
            state = "idle";
        }
        break;
}
#endregion

#region Movement
	
	var movement = object_movement(hsp,vsp,grv,face);
	hsp=movement[0];
	vsp=movement[1];
	
#endregion

blink_effect(id);

#region Fuentes de daño

//Hitbox del player
if instance_place(x,y,oPlayer_Air_Attack_HB) || instance_place(x,y,oPlayer_Attack_HB){
	enemy_take_damage(self.id, 1, false,3,3,oPlayer.x, 180);
}

//Explosion de Bomba
var _collision = instance_place(x,y,oBomb_Explosion)
if instance_exists(_collision){
	enemy_take_damage(self.id, 3, false,5,3,_collision.x, 180);
}

//Smallbox
var _collision = instance_place(x,y,oSmallBox)
if instance_exists(_collision){
	enemy_take_damage(self.id, 3, false,5,3,_collision.x, 180);
}
#endregion

if hp<=0 instance_destroy();