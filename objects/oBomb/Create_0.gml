event_inherited();

function Destroy(){
	instance_create_depth(x,y-sprite_height/3,depth,oBomb_Explosion);
	instance_destroy();		
}
//Bouncing Mechanic
hsp = 4;
vsp = -4;
grv = 0.5;
xFriction = 0.9; //Reduccion de velocidad horizontal
bounce_factor = 0.9;

timerStart = false;
timerFrames = 300;