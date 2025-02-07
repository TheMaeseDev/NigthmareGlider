event_inherited();

function Destroy(){
	instance_create_depth(x,y-sprite_height/3,depth-1,oBomb_Explosion);
	cameraShake(4,7);
	instance_destroy();		
}
//Bouncing Mechanic
hspDefault = 4.5;
vspDefault = -4.5;
hsp = hspDefault;
vsp = vspDefault;
grv = 0.5;
xFriction = 0.8; //Reduccion de velocidad horizontal
bounce_factor = 0.7;
canBounce = true;
lastBounceY = 0;

timerStart = false;
timerFrames = 300;