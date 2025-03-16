image_angle += -hsp*5; // Rotar según la velocidad horizontal

var _collision = instance_place(x,y,oGrabbable);
if instance_exists(_collision){
	_collision.Destroy();
}

var _collision = instance_place(x,y+1+vsp,oGrabbable);
if instance_exists(_collision){
	_collision.Destroy();
}

var _movement = bounceBehaviour(hsp,vsp,grv,face,bounceFactor,xFriction);
hsp = _movement[0];
vsp = _movement[1];

if place_meeting(x,y,oPlayer){
	oPlayer.takeDamage(2,x);
	Destroy();
}

if place_meeting(x,y,oNitroBox){
	oPlayer.takeDamage(1,x);	
	
}

