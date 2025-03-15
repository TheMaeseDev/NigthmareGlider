event_inherited();
if (global.paused==true) exit;
if jumpDelay<=0{
	vsp+=jumpSpeed;
	jumpDelay = jumpFrames;
}else{
	jumpDelay--;	
}


if instance_exists(oPlayer){
	if (x<oPlayer.x) face=1;
	if (x>oPlayer.x) face=-1;
}

image_xscale = -face;