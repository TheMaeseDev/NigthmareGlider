//Move in a circle

dir+= rotSpd;

//Get our target positions
var _targetX = xstart + lengthdir_x(radius,dir);
var _targetY = ystart + lengthdir_y(radius,dir);

// Determinar la velocidad en base al tipo de movimiento
switch (movementType) {
    case "circular":
        xspd = _targetX - x;
        yspd = _targetY - y;
        break;
        
    case "horizontal":
        xspd = _targetX - x;
        yspd = 0;
        break;

    case "vertical":
        xspd = 0;
        yspd = _targetY - y;
        break;
}

// Aplicar el movimiento
x += xspd;
y += yspd;