
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
		
		//Enciende la bomba
		timerStart=true;
		
		break;
	case States.Flying:
		//Activo la colision
		mask_index=sBomb;
		
		//Situaciones en la que explota
		if place_meeting(x,y,oPlayer)	//Si choca al player
		|| place_meeting(x,y+vsp+1,oGrabbable) //Si "pisa" con algun objeto agarrable
		|| place_meeting(x-(0.5*sign(hsp)),y,oPlayer) //Si el chocar la choca desde atras
		|| place_meeting(x+hsp,y,oWall) //Si choca una pared de costado
		|| place_meeting(x+hsp,y,oSemiSolidWall)
		|| place_meeting(x,y,oEnemyBase) //Si choca con un enemigo
		|| place_meeting(x,y,oNitroBox) //Si choca con una nitro
		{
			Destroy();	
		}
		
		//Cuando para de rebotar cambia de estado
		if vsp==0 && hsp==0 estado=States.IdleOn;
		break;
	case States.IdleOn:
		if(place_meeting(x,y-1,oPlayer)) Destroy(); //Si el player la pisa estando ON
		break;
}

//Se aplica el movimiento
movement = bounce_behaviour(hsp,vsp,grv,face,bounceFactor,xFriction);
hsp=movement[0];
vsp=movement[1];

//Codigo de explosion por tiempo
if timerStart{
	timerFrames--;
	
	//Sprite Control
	sprite_index = sBomb_On;
	
}

if timerFrames<=0{
	Destroy();
}

//Explota cuando el player la golpea.
if place_meeting(x,y,oPlayer_Attack_HB) || place_meeting(x,y,oPlayer_Air_Attack_HB){
	Destroy();	
}