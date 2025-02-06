
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

if hp<=0 instance_destroy();

//Colision con Player
var _player = instance_place(x,y,oPlayer);

if _player != noone{
	with(_player){
		takeDamage(1,other.x);
	}
}