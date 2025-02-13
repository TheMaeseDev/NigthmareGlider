
var movement = object_movement(hsp,vsp,grv,face);
hsp = movement[0]; 
vsp = movement[1];


//Colisiones

if place_meeting(x,y,oPlayer)
|| place_meeting(x,y,oMoveObject)
|| place_meeting(x,y,oGrabbable)
|| place_meeting(x,y,oEnemyBase)
|| place_meeting(x,y,oBomb_Explosion)
|| place_meeting(x,y,oTntBox)
|| place_meeting(x,y,oPlayer_Attack_HB)
||place_meeting(x,y,oPlayer_Air_Attack_HB)
{
	Destroy();	
}
