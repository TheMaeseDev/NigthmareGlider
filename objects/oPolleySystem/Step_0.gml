
var playerOnPlatA = place_meeting(platA.x, platA.y - 1, oPlayer);
var playerOnPlatB = place_meeting(platB.x, platB.y - 1, oPlayer);

if (playerOnPlatA || playerOnPlatB) {
	global.mensaje="El player esta arriba";
    platA.moving = true;
    platB.moving = true;
} else {
	global.mensaje="Alla estan arriba";
    platA.moving = false;
    platB.moving = false;
    
    // Si el sistema tiene activado el retorno a reposo
    if (returnToRest) {
        // Mover ambas plataformas hacia el nivel de reposo
        if (platA.y != restY) platA.y = lerp(platA.y, restY, 0.05);
        if (platB.y != restY) platB.y = lerp(platB.y, restY, 0.05);
    }
}