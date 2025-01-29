//Se rompe si caigo rapido sobre la caja
playerInstance = instance_place(x,y-1,oPlayer);

if playerInstance != noone{
	if playerInstance.glideKey{
		canBreake = false;
	}else if canBreake{
		instance_destroy();
	}
}

if playerInstance == noone{
	canBreake = true;	
}

