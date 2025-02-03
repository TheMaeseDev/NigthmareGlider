
//Follow Player
if(grabbed){
	x=owner.x + 15*owner.face;
	y=owner.y-5;
	flying = false;
	hsp = hspDefault;
	vsp = vspDefault;
	mask_index = sNoMask;
	timerStart = true;
}
else{
	mask_index = sBomb;	
}

//Si "pisa" una bomba, explota
if(place_meeting(x,y,oBomb)) Destroy();

if flying{
	x+=hsp*face;
	vsp += grv;
	
	//Si "pisa" una cajita, explota.
	if(place_meeting(x,y+vsp,oSmallBox)) Destroy();
	
	//Si "pisa" una bomba, explota.
	if(place_meeting(x,y+vsp,oBomb)) Destroy();
	
	//Si toca el suelo, rebota.
	if ( place_meeting(x,y+vsp,oWall) || place_meeting(x,y+vsp,oSemiSolidWall) ){
		vsp = max(vsp*-bounce_factor, -8);
		hsp *= xFriction;
		
		//Detener si la energia de rebote es muy baja
		if(abs(vsp)<1){
			vsp = 0;
		}
		if(abs(hsp)< 0.2){
			hsp = 0;	
		}
		
		if vsp == 0 || hsp == 0{
			flying = false;
		}
	}
	
	//Y Collision
	if (place_meeting(x, y + vsp, oWall) || place_meeting(x, y + vsp, oSemiSolidWall)) {
	    while (!place_meeting(x, y + sign(vsp), oWall) && !place_meeting(x, y + sign(vsp), oSemiSolidWall)) {
	        y += sign(vsp);
	    }
	    vsp = 0;
	}
	y += vsp;
	
	//Si toca cualquier "pared" de costado, explota.
	if place_meeting(x+(1*face),y,oWall) || place_meeting(x+(1*face),y,oSemiSolidWall){
		Destroy();
	}
	
	//Si choca un enemigo, explota
	if(place_meeting(x,y,oEnemyBase)) Destroy();
	
	//Colision con el player
	if(place_meeting(x,y,oPlayer)) Destroy();
	if(place_meeting(x,y-1,oPlayer)) Destroy();
	if(place_meeting(x+(-2*face),y,oPlayer)) Destroy();
}

//Codigo de explosion por tiempo
if timerStart{
	timerFrames--
	//Sprite Control
	sprite_index = sBomb_On;
	if(place_meeting(x,y-1,oPlayer)) Destroy();
}
if timerFrames<=0{
	Destroy();
}

//Explota cuando el player la golpea.
if place_meeting(x,y,oPlayer_Attack_HB) || place_meeting(x,y,oPlayer_Air_Attack_HB){
	Destroy();	
}