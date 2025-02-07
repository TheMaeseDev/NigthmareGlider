event_inherited();

if jumpDelay<=0{
	vsp+=jumpSpeed;
	jumpDelay = jumpFrames;
}else{
	jumpDelay--;	
}


global.mensaje = jumpDelay;