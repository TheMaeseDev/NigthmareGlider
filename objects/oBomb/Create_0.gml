event_inherited();

function Destroy(){
	instance_create_depth(x,y-sprite_height/3,depth,oBomb_Explosion);
	instance_destroy();		
}
//Bouncing Mechanic
hsp = 4.5;
vsp = -4.5;
grv = 0.5;
xFriction = 0.8; //Reduccion de velocidad horizontal
bounce_factor = 0.7;
canBounce = true;
lastBounceY = 0;

timerStart = false;
timerFrames = 300;