event_inherited();

function Destroy(){
	instance_create_depth(x,y-sprite_height/3,depth-1,oBomb_Explosion);
	cameraShake(4,7);
	instance_destroy();		
}

hsp=0
vsp=0

estado = States.IdleOff;
grv = 0.5;
xFriction = 0.8;
bounceFactor = 0.7;
face = 1;
//Variables de explosion por tiempo
timerStart = false;
timerFrames = 300;