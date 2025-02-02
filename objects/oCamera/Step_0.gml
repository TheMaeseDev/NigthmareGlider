//Fullscreen toggle
if keyboard_check_pressed(vk_f8){
	window_set_fullscreen(!window_get_fullscreen());	
}

cam = view_camera[0];

//Exit if there is no player
if !instance_exists(oPlayer) exit;

//Get camera size
var _camWidth = camera_get_view_width(cam);
var _camHeight = camera_get_view_height(cam);

//Get camera target coordinates
var _camX = oPlayer.x - _camWidth/2;
var _camY = oPlayer.y - _camHeight/2

//Constrain camera to room borders
_camX = clamp(_camX,0,room_width - _camWidth);
_camY = clamp(_camY,0,room_height - _camHeight);

//Set cam coordinates variables
finalCamX += (_camX-finalCamX)*camTrailSpd;
finalCamY += (_camY-finalCamY)*camTrailSpd;

// Agregar temblor si está activo
var shakeX = 0;
var shakeY = 0;

if (global.shakeTimer > 0) {
    global.shakeTimer--; // Reducimos la duración
    shakeX = random_range(-global.shakeMagnitude, global.shakeMagnitude);
    shakeY = random_range(-global.shakeMagnitude, global.shakeMagnitude);
}

//Set camera coordinates
camera_set_view_pos(cam, _camX +shakeX, _camY+shakeY);