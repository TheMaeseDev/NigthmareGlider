yspd=0;
xspd=0;

polleyAttached = noone;
pairedPlatform = noone; // Se asignará desde el controlador

//speedMax = 2;   // Velocidad máxima

grv = 0.05; // Cuán rápido acelera
returnSpeed = -0.02;

maxUpSpdDefault = 2.5;
maxFallSpdDefault = -2.5;

maxUpSpd =maxUpSpdDefault;
maxFallSpd = maxFallSpdDefault;

canMove = false;  // Se activará cuando el jugador se suba
moved = false; // Se esta moviendo?
topLimit = 0;   // Se asignará desde el controlador
bottomLimit = 0;
startY = y;

canReturn = true;
state = "idle";
rol = noone;
mensajeLoco= "";