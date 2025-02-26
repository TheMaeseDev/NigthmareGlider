
var _movement = object_movement(hsp,vsp,grv,face);
hsp=_movement[0];
vsp=_movement[1];

blink_effect(id);

switch (state) {
    case ErizoState.Rolling:
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
		sprite_index=sEnemy_Patricio_Idle;
        stopped_timer--;
        if (stopped_timer <= 0) {
            face *= -1; // Invertir dirección
            state = ErizoState.Rolling;
        }
        break;

    case ErizoState.Idle:
		sprite_index=sEnemy_Patricio_Idle;
        jump_timer--;
        if (jump_timer <= 0) {
            state = ErizoState.Jumping;
            vsp = jump_power;
        }
        break;

    case ErizoState.Jumping:
		sprite_index=sEnemy_Patricio_Spin;
        if (place_meeting(x, y + 1, oWall)) {
            state = ErizoState.Idle;
            jump_timer = stopped_frames;
        }
        break;
}
image_xscale = face;

global.mensaje = state;