// Control del tiempo de activación
fire_timer--;

if (fire_timer <= 0) {
    if (!active) {
        active = true;
        fire_timer = fire_duration;
    } else {
        active = false;
        fire_timer = fire_delay;
    }
}

// Expansión y retracción del fuego
if (active) {
    if (current_length < fire_length) {
        current_length += fire_step;
    }
} else {
    if (current_length > 0) {
        current_length -= fire_step;
    }
}

// Crear las llamas individuales
if (current_length > 0) {
    for (var i = 1; i <= current_length / 12; i++) {
        var fx = x + lengthdir_x(i * 12, fire_direction);
        var fy = y + lengthdir_y(i * 12, fire_direction);
        
        if (!position_meeting(fx, fy, oFlame)) {
            instance_create_depth(fx, fy, 0, oFlame);
        }
    }
}