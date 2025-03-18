// Fullscreen toggle
if keyboard_check_pressed(vk_f8){
    window_set_fullscreen(!window_get_fullscreen());    
}

get_cam_controls();

cam = view_camera[0];

// Exit if there is no player
if !instance_exists(oPlayer) exit;

// Get camera size
var _camWidth = camera_get_view_width(cam);
var _camHeight = camera_get_view_height(cam);

// Definir el área de tolerancia
var marginX = _camWidth * 0.47;

// Definir la deadzone en Y con más tolerancia y desplazada hacia abajo
var marginY_Top = _camHeight * 0.30;   // Menos margen arriba (30%)
var marginY_Bottom = _camHeight * 0.4; // Más margen abajo (60%)

// Obtener la posición de la cámara actual
var camLeft = finalCamX + marginX;
var camRight = finalCamX + _camWidth - marginX;
var camTop = finalCamY + marginY_Top; 
var camBottom = finalCamY + _camHeight - marginY_Bottom; 

// Definir las nuevas coordenadas de la cámara
var _camX = finalCamX;
var _camY = finalCamY;

// Definir la velocidad de transición de la deadzone
var deadzoneMoveStep = oPlayer.xspd*oPlayer.face; // Cuánto se mueve por frame
var deadzoneMaxOffset = 50; // Límite máximo de desplazamiento

// Comprobar si el jugador está saliendo del área de tolerancia en X
if (oPlayer.x < camLeft) {
    _camX = oPlayer.x - marginX;
    smoothDeadzoneOffsetX -= deadzoneMoveStep;
} else if (oPlayer.x > camRight) {
    _camX = oPlayer.x - _camWidth + marginX;
    smoothDeadzoneOffsetX += deadzoneMoveStep;
}

// Limitar el desplazamiento del deadzone dentro de los valores máximos permitidos
smoothDeadzoneOffsetX = clamp(smoothDeadzoneOffsetX, -deadzoneMaxOffset, deadzoneMaxOffset);


// Comprobar si el jugador está saliendo del área de tolerancia en Y
if (oPlayer.y < camTop) {
    _camY = oPlayer.y - marginY_Top;
} else if (oPlayer.y > camBottom) {
    _camY = oPlayer.y - _camHeight + marginY_Bottom;
}

// Constrain la cámara a los bordes del room
_camX = clamp(_camX, 0, room_width - _camWidth);
_camY = clamp(_camY, 0, room_height - _camHeight);

var arrowX = camRightKey - camLeftKey; // → Derecha = 1, Izquierda = -1
var arrowY = camDownKey - camUpKey;   // ↓ Abajo = 1, Arriba = -1

// Factor de desplazamiento (puedes ajustarlo)
var maxCamOffsetX = 32;
var maxCamOffsetY = 32;

// Interpolar suavemente los valores para evitar movimientos bruscos
camOffsetX += (arrowX * maxCamOffsetX - camOffsetX) * 0.1;
camOffsetY += (arrowY * maxCamOffsetY - camOffsetY) * 0.1;

// Limitar desplazamiento dentro de los bordes del room
var minCamX = 0;
var maxCamX = room_width - _camWidth;
var minCamY = 0;
var maxCamY = room_height - _camHeight;

camOffsetX = clamp(camOffsetX, minCamX - finalCamX, maxCamX - finalCamX);
camOffsetY = clamp(camOffsetY, minCamY - finalCamY, maxCamY - finalCamY);

if oPlayer.onGround yCamTrailSpd=0.1;
else yCamTrailSpd=0.85;

// Aplicar interpolación suave para la cámara
finalCamX += (_camX - finalCamX) * xCamTrailSpd;
finalCamY += (_camY - finalCamY) * yCamTrailSpd;

// Agregar temblor si está activo
var shakeX = 0;
var shakeY = 0;

if (global.shakeTimer > 0) {
    global.shakeTimer--; // Reducimos la duración
    shakeX = random_range(-global.shakeMagnitude, global.shakeMagnitude);
    shakeY = random_range(-global.shakeMagnitude, global.shakeMagnitude);
}

// *** Constrain finalCamX incluyendo el desplazamiento del deadzone ***
var constrainedFinalCamX = clamp(finalCamX + smoothDeadzoneOffsetX, 0, room_width - _camWidth);
var constrainedFinalCamY = clamp(finalCamY, 0, room_height - _camHeight);

// Set camera position con desplazamiento manual
camera_set_view_pos(cam, constrainedFinalCamX + camOffsetX + shakeX, constrainedFinalCamY + camOffsetY + shakeY - 30);

x1=camLeft;
x2=camRight;
y1=camTop;
y2=camBottom;