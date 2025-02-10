
function Collected(){
	hsp=-3*-oPlayer.face
	vsp=-4;
}

enum Behaviour{
	idle,
	bounce
}

behaviour=Behaviour.bounce;

vsp= 0;
hsp= 0;
grv= 0.5;
face = 1;

xFriction = 0.8; //Reduccion de velocidad horizontal
bounce_factor = 0.7;
min_bounce_speed = 0.5;