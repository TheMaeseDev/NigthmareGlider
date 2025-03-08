
xspd=0;
yspd=0;

restFrames = 90;
restTimer = restFrames;

sprite_idle = sEnemy_Rockhead; // Sprite por defecto
sprite_upHit = sEnemy_Rockhead_uHit;
sprite_downHit = sEnemy_Rockhead_dHit;

state = "rest"; //"rest" or "moving"

accel = 0.25;  // Aceleración
maxSpeed = 5; // Velocidad máxima
dirX = 0;     // Dirección en X (-1, 0, 1)
//dirY = 1;     // Dirección en Y (-1, 0, 1)