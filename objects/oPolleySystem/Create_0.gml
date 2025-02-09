
rangeY = 100;   // Altura máxima que pueden moverse
separation = 100; // Distancia entre plataformas

// Crear plataformas en posiciones relativas al controlador
platA = instance_create_layer(x, y, depth, oPolleyPlat);
platB = instance_create_layer(x+separation, y, depth, oPolleyPlat);

// Asignar plataformas como pareja
platA.pairedPlatform = platB;
platB.pairedPlatform = platA;

// Asignar polea a la que esta atada
platA.polleyAttached = id;
platB.polleyAttached = id;

// Definir límites de movimiento
platA.topLimit = y - rangeY;
platA.bottomLimit = y + rangeY;
platB.topLimit = y - rangeY;
platB.bottomLimit = y + rangeY;

// Indicar que inicialmente están detenidas
platA.state = "idle";
platB.state = "idle";

//Establecer roles
platA.rol = "activo";
platB.rol = "pasivo";

//Indicar grosor
widthPlatA = 3;
widthPlatB = 3;
platA.image_xscale = widthPlatA;
platB.image_xscale = widthPlatB;

returnToRest = true; // Si es `true`, las plataformas vuelven al mismo nivel al soltar
restY = y; // Nivel de reposo
maxReturnSpeed = 0.5;

