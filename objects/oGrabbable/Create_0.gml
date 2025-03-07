event_inherited();

function Destroy(){
	cameraShake(1,1);
	instance_destroy();		
}

enum States{
	IdleOff,
	Grabbed,
	Flying,
	IdleOn
}

//Variable para manejo de estados
estado=States.IdleOff;
movement=noone;

//Variables de movimiento
hspDefault = 0;
vspDefault = 0;
hsp = hspDefault;
vsp = vspDefault;
grv = 0.5;
xFriction = 0.8; //Reduccion de velocidad horizontal
bounceFactor = 0.7;
face = 1;

//Variables para Grab
grabbed = false;
owner = noone;

//Velocidades al ser lanzadas
throwHsp = 4.5;
throwVsp = -4.5;


myId = string(x)+" - "+string(y);
