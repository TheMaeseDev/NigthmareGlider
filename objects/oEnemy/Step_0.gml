
var _existHB=instance_place(x,y,oPlayer_Attack_HB);

if _existHB != noone{
	beignHitedBy = _existHB;
}

if beignHitedBy != hitedBy{
	hitedBy = beignHitedBy;
	
	//Que pasa cuando recibe un golpe?
	healthPts--;
}

if healthPts<=0 instance_destroy();