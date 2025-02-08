
if (moving) {
    // Aumentar velocidad progresivamente hasta el máximo
    currentSpeed = min(currentSpeed + acceleration, speedMax);
} else {
    // Si no está en movimiento, reducir velocidad gradualmente
    currentSpeed = max(currentSpeed - acceleration, 0);
}

// Mover la plataforma si está en el rango permitido
var nextY = y + currentSpeed * sign(direction);
if (nextY >= topLimit && nextY <= bottomLimit) {
    y = nextY;
} else {
    direction *= -1; // Cambiar dirección si llegó a un límite
}