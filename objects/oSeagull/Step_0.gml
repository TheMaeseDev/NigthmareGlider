// Buscar al jugador
var player = instance_nearest(x, y, oPlayer);

switch (state) {
    case "Idle":
        // Si el jugador está dentro del rango de detección, cambiar a "Chasing"
        if (player != noone && point_distance(x, y, player.x, player.y-sprite_height/2) < detectionRange) {
            state = "Chasing";
        }
        break;

    case "Chasing":
        // Seguir al jugador horizontalmente
        x = lerp(x, player.x, speedChase); 

        // Mantenerse en la altura inicial
        y = lerp(y, player.y-sprite_height*2, speedChase);

        // Si el jugador está cerca, preparar el ataque
        if (point_distance(x, y, player.x, player.y-sprite_height/2) < attackRange) {
            attackTargetX = player.x;
            attackTargetY = player.y;
			yBeforeAttack = y;

            state = "Attack";
            alarm[0] = 30; // Esperar antes de atacar
        }
        break;

    case "Attack":
        if (alarm[0] <= 0) {
            invulnerable = true;
			
            // Moverse rápidamente hacia el punto donde estaba el jugador
            x += sign(attackTargetX - x) * speedAttack;
            y += sign(attackTargetY - y) * speedAttack;

            // Si llega al punto de ataque, cambiar a "getUp"
            if (point_distance(x, y, attackTargetX, attackTargetY) < 5) {
                state = "getUp";
                invulnerable = false;
            }
        }
        break;

    case "getUp":
        // Volver a la altura original
        y = lerp(y, yBeforeAttack, 0.1);

        // Si llega a la altura original, cambiar de estado
        if (abs(y - yBeforeAttack) < 1) {
            state = "Idle";
        }
        break;
}