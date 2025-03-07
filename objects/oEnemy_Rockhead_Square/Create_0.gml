function changeDirection() {
    if (dirX == 1 && dirY == 0) { 
        dirX = 0;
        dirY = -rotationDir;
    } 
    else if (dirX == 0 && dirY == -1) { 
        dirX = -rotationDir;
        dirY = 0;
    } 
    else if (dirX == -1 && dirY == 0) { 
        dirX = 0;
        dirY = rotationDir;
    } 
    else if (dirX == 0 && dirY == 1) { 
        dirX = rotationDir;
        dirY = 0;
    }
}

xspd=0;
yspd=0;

restFrames = 90;
restTimer = restFrames;

state = "rest"; //"rest" or "moving"

accel = 0.25;  // Aceleración
maxSpeed = 5; // Velocidad máxima
dirX = 1;     // Dirección en X (-1, 0, 1)
dirY = 0;     // Dirección en Y (-1, 0, 1)

// Definir sentido de giro: 1 = horario, -1 = antihorario
rotationDir = -1; 