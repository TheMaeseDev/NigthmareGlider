
switch (estado){
	case States.IdleOff:
		break;
		
	case States.Grabbed:
		//No gana velocidad
		hsp = 0;
		vsp = 0;
		
		//Sigue al Player
		x=owner.x + 15*owner.face;
		y=owner.y-5;

		//Desactiva la colision
		mask_index = sNoMask;
		break;
	case States.Flying:
		//Activo la colision
		mask_index=sSmallBox;
		
		var _boxHitted = instance_place(x+hsp,y,oGrabbable);
		if instance_exists(_boxHitted){
			with _boxHitted Destroy();
			Destroy();
		}
		
		var _boxHitted = instance_place(x,y+vsp,oGrabbable);
		if instance_exists(_boxHitted){
			with _boxHitted Destroy();
			Destroy();
		}
		
		//Situaciones en la que se rompe
		if place_meeting(x,y,oEnemyBase) //Si choca con un enemigo
		|| place_meeting(x,y+vsp,oGrabbable) //Si "pisa" con algun objeto agarrable
		|| place_meeting(x+hsp,y,oWall) //Si choca una pared de costado
		|| place_meeting(x+hsp,y,oSemiSolidWall)
		|| place_meeting(x,y+vsp,oWall)
		|| place_meeting(x,y+vsp,oSemiSolidWall)
		|| place_meeting(x,y,oNitroBox) //Si choca con una nitro
		{
			Destroy();	
		}
}

//Si es atacada por el Player
if place_meeting(x,y,oPlayer_Attack_HB) || place_meeting(x,y,oPlayer_Air_Attack_HB){
		Destroy();	
}	

//Aplica movimiento;
var movement = object_movement(hsp,vsp,grv,face);
hsp = movement[0]; 
vsp = movement[1];

