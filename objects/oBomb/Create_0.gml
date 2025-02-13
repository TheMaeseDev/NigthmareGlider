event_inherited();

function Destroy(){
	instance_create_depth(x,y-sprite_height/3,depth-1,oBomb_Explosion);
	cameraShake(4,7);
	instance_destroy();		
}

//Variables de explosion por tiempo
timerStart = false;
timerFrames = 300;