// Posición inicial
startX = x;
startY = y;

// Altura en la que debe mantenerse mientras persigue
targetY = startY;

// Variables de movimiento
speedChase = 0.008;   // Velocidad en Chasing
speedAttack = 1;  // Velocidad en Attack
speedGetUp = 1; // Velocidad en getUp

// Rangos de detección
detectionRange = 200; // Distancia para detectar al jugador
attackRange = 100;     // Distancia para atacar

// Variables de ataque
attackTargetX = 0;
attackTargetY = 0;
invulnerable = false;

// Estado inicial
state = "Idle";

yBeforeAttack=0;