/// enemy_take_damage(_enemy, _damage, _knockback, _attackerX, _invulnTime)
function enemy_take_damage(_enemy, _damage, _knockback, _kbX, _kbY, _attackerX, _invulnTime) {
    with (_enemy) {
        // Si es invulnerable, ignorar el golpe
        if (invulnerable) return;
        
		//Chequear si es golpe final
		if hp-_damage<=0{
			_knockback=true;
			_kbX = 3;
			_kbY = 4;
		}
        // Restar vida
        hp -= _damage;
		
		// Si el enemigo tiene un sprite de daño, cambiar al estado "hurt"
        if sprHitted != noone{
            state = "hurt";
            sprite_index = sprHitted;
            image_index = 0;
            image_speed = 1;
        }

        // Hacerlo invulnerable
        invulnerable = true;
		maxBlinkTimer = _invulnTime;
        invulnTimer = _invulnTime; // Duración de la invulnerabilidad

        // Aplicar parpadeo (alternar visibilidad)
        blinkTimer = _invulnTime;
        blinkSpeed = 5; // Velocidad del parpadeo
        
        // Si tiene knockback activado
        if (_knockback) {
            // Determinar dirección del knockback según la posición del atacante
            var _knockDir = (x < _attackerX) ? -1 : 1;
            hsp = _knockDir * _kbX;  // Empuje horizontal
            vsp = -_kbY;  // Pequeño salto al recibir daño
        }
    }
}