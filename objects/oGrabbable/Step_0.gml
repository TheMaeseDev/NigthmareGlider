
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
		mask_index=sBomb;
		
		//Situaciones en la que explota
		if place_meeting(x+hsp,y,oWall) //Si choca una pared de costado
		|| place_meeting(x+hsp,y,oSemiSolidWall)
		|| place_meeting(x,y,oEnemyBase) //Si choca con un enemigo
		|| place_meeting(x,y,oNitroBox) //Si choca con una nitro
		{
			Destroy();	
		}
		
	case States.IdleOn:
		if(place_meeting(x,y-1,oPlayer)) Destroy(); //Si el player la pisa estando ON
		break;
}
