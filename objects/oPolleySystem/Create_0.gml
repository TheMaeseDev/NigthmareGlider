
rangeY = 120;   // Altura máxima que pueden moverse
separation = 80; // Distancia entre plataformas

// Crear plataformas en posiciones relativas al controlador
platA = instance_create_layer(x, y, depth, oPolleyPlat);
platB = instance_create_layer(x+separation, y, depth, oPolleyPlat);

// Asignar plataformas como pareja
platA.pairedPlatform = platB;
platB.pairedPlatform = platA;

// Definir límites de movimiento
platA.topLimit = y - rangeY;
platA.bottomLimit = y + rangeY;
platB.topLimit = y - rangeY + separation;
platB.bottomLimit = y + rangeY + separation;

// Indicar que inicialmente están detenidas
platA.moving = false;
platB.moving = false;

returnToRest = true; // Si es `true`, las plataformas vuelven al mismo nivel al soltar
restY = y; // Nivel de reposo