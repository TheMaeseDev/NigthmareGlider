event_inherited();

function throwBarrel(){
	var _barrel = instance_create_depth(x+(10*face),y-30,depth,oBounce_Barrel);
	_barrel.hsp = 2*face;
	bombThrowTimer=bombThrowFrames;
}

// Definir estados
enum BarrelThrowerState{
    IDLE,
    THROWING,
    PUNCHING
}

// Variables de control
barrelThroweState = BarrelThrowerState.IDLE;
barrelThrown=false;

//Variables heredadas
hp=2;
kbx=0;
kby=3;
canTakeDamage=true;


bombThrowFrames=180;
bombThrowTimer=bombThrowFrames;
punchFrames=60;
punchTimer=punchFrames;
alreadyPunch = false;
golpe=noone;
