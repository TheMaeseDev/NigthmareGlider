
var _existHB=instance_place(x,y,oPlayer_Attack_HB);
var _existAirHB=instance_place(x,y,oPlayer_Air_Attack_HB);

//Meele Attack
if _existHB != noone{
	beignHitedBy = _existHB;
}

if _existAirHB != noone{
	beignHitedBy = _existAirHB;
}

if (beignHitedBy != hitedBy){
	hitedBy = beignHitedBy;
	
	//Que pasa cuando recibe un golpe?
	getHitted(1);
}

//global.mensaje = _existAirHB;

if healthPts<=0 instance_destroy();