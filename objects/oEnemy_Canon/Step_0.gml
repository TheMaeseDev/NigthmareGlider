

shootTimer--;

if shootTimer<=0{
	shootTimer = shootFrames;
	bombInstance = instance_create_depth(x,y,depth,oBomb);
	with bombInstance{
		face = -1;
		flying=true;
		timerStart = true;
	}
}
