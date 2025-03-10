// Fullscreen toggle
if keyboard_check_pressed(vk_f8){
    window_set_fullscreen(!window_get_fullscreen());    
}

cam = view_camera[0];

// Exit if there is no player
if !instance_exists(oPlayer) exit;

// Get camera size
var _camWidth = camera_get_view_width(cam);
var _camHeight = camera_get_view_height(cam);

// Definir el área de tolerancia (15% de la pantalla a cada lado)
var marginX = _camWidth * 0.48;
var marginY = _camHeight * 0.48;

// Obtener la posición de la cámara actual
var camLeft = finalCamX + marginX;
var camRight = finalCamX + _camWidth - marginX;
var camTop = finalCamY + marginY;
var camBottom = finalCamY + _camHeight - marginY;

// Definir las nuevas coordenadas de la cámara
var _camX = finalCamX;
var _camY = finalCamY;

// Comprobar si el jugador está saliendo del área de tolerancia en X
if (oPlayer.x < camLeft) {
    _camX = oPlayer.x - marginX; // Empujar la cámara a la izquierda
} else if (oPlayer.x > camRight) {
    _camX = oPlayer.x - _camWidth + marginX; // Empujar la cámara a la derecha
}

// Comprobar si el jugador está saliendo del área de tolerancia en Y
if (oPlayer.y < camTop) {
    _camY = oPlayer.y - marginY; // Empujar la cámara hacia arriba
} else if (oPlayer.y > camBottom) {
    _camY = oPlayer.y - _camHeight + marginY; // Empujar la cámara hacia abajo
}

// Constrain la cámara a los bordes del room
_camX = clamp(_camX, 0, room_width - _camWidth);
_camY = clamp(_camY, 0, room_height - _camHeight);

// Aplicar interpolación suave para la cámara
finalCamX += (_camX - finalCamX) * camTrailSpd;
finalCamY += (_camY - finalCamY) * camTrailSpd;

// Agregar temblor si está activo
var shakeX = 0;
var shakeY = 0;

if (global.shakeTimer > 0) {
    global.shakeTimer--; // Reducimos la duración
    shakeX = random_range(-global.shakeMagnitude, global.shakeMagnitude);
    shakeY = random_range(-global.shakeMagnitude, global.shakeMagnitude);
}

// Set camera position
camera_set_view_pos(cam, finalCamX + shakeX, finalCamY + shakeY-30);