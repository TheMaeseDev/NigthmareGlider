
var movement = object_movement(hsp,vsp,grv,face);
hsp = movement[0]; 
vsp = movement[1];


//Colisiones

if place_meeting(x,y,oPlayer)
|| place_meeting(x,y,oMoveObject)
{
	Destroy();	
}
