yspd=0;
xspd=0;

polleyAttached = noone;
pairedPlatform = noone; // Se asignará desde el controlador

//speedMax = 2;   // Velocidad máxima

grv = 0.05; // Cuán rápido acelera
returnSpeed = -0.03;
maxUpSpd = 3;
maxFallSpd = -3;
ysp = 0; // Velocidad vertical

canMove = false;  // Se activará cuando el jugador se suba
moved = false; // Se esta moviendo?
topLimit = 0;   // Se asignará desde el controlador
bottomLimit = 0;
startY = y;

canReturn = true;
state = "idle";
rol = noone;
mensajeLoco= "";