
// Si el sistema tiene activado el retorno a reposo
if (returnToRest && !platA.canMove && !platB.canMove) {
	// Calcular distancia a la posición de reposo
    var distA = abs(platA.y - restY);
    var distB = abs(platB.y - restY);
    
    // Acelerar más al principio y reducir al acercarse
    var speedA = min(distA * 0.1, maxReturnSpeed);
    var speedB = min(distB * 0.1, maxReturnSpeed);
    
    // Aplicar movimiento con aceleración controlada
    with platA move_towards_point(x, other.restY, speedA);
    with platB move_towards_point(x, other.restY, speedB);
    
    // Detenerse si están cerca del punto de reposo
    if (distA < 0.5) platA.y = restY;
    if (distB < 0.5) platB.y = restY;
}
