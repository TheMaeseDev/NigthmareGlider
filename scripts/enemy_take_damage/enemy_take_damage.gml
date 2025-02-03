/// enemy_take_damage(_enemy, _damage, _knockback, _attackerX, _invulnTime)
function enemy_take_damage(_enemy, _damage, _knockback, _attackerX, _invulnTime) {
    with (_enemy) {
        // Si es invulnerable, ignorar el golpe
        if (invulnerable) return;
        
        // Restar vida
        hp -= _damage;
		
		// Cambiar sprite a animación de golpe
        /*sprite_index = sprHitted;
        image_index = 0;
        image_speed = 1;*/

        // Hacerlo invulnerable
        invulnerable = true;
        invulnTimer = _invulnTime; // Duración de la invulnerabilidad

        // Aplicar parpadeo (alternar visibilidad)
        blinkTimer = _invulnTime;
        blinkSpeed = 5; // Velocidad del parpadeo
        
        // Si tiene knockback activado
        if (_knockback) {
            // Determinar dirección del knockback según la posición del atacante
            var _knockDir = (x < _attackerX) ? -1 : 1;
            hsp = _knockDir * 3;  // Empuje horizontal
            vsp = -3;  // Pequeño salto al recibir daño
        }
    }
}