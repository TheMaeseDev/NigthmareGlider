
//Si el player lo toca, se ejecuta la funcion de objeto agarrado
if instance_place(x,y,oPlayer){
	Collected();
}

if behaviour==Behaviour.bounce{
	var _movement = bounce_behaviour(hsp,vsp,grv,face,bounce_factor,xFriction);
	hsp = _movement[0];
	vsp = _movement[1];
}