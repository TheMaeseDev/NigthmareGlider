/// blink_effect(_enemy)
function blink_effect(_enemy) {
    with (_enemy) {
        if (invulnerable) {
            if (blinkTimer > 0) {
                blinkTimer--;
                image_alpha = (blinkTimer div blinkSpeed) mod 2; // Alterna visibilidad
            } else {
                invulnerable = false;
                image_alpha = 1; // Restaurar visibilidad
            }
        }
    }
}