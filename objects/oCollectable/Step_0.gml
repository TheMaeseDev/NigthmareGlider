
//Si el player lo toca, se ejecuta la funcion de objeto agarrado
if instance_place(x,y,oPlayer){
	Collected();
}

/*if behaviour==Behaviour.idle{
	
}*/


if behaviour==Behaviour.bounce{
	
//X collision
	var _subPixel = .5;
	if place_meeting(x+hsp, y, oWall){
		//First check if there is a slope to go up
		if !place_meeting(x+hsp,y-abs(hsp)-1,oWall){
			while place_meeting(x+hsp,y,oWall){ y-=_subPixel};
		}
		//Next, check for ceiling slopes, otherwise, do a regular collision
		else{
			//Ceiling Slopes
			if(!place_meeting(x+hsp,y+abs(hsp)+1,oWall)){
				while place_meeting(x+hsp,y,oWall) {y+= _subPixel}	
			}
			//Normal Collision
			else{
				//Scoot up to wall precisely
				var _pixelCheck = _subPixel * sign(hsp);
				while !place_meeting(x + _pixelCheck, y,oWall){
					x+=_pixelCheck;
				}
				//Set xspd to zero to "collide"
				hsp=-hsp;
				vsp-=1;
			}
		}	
	}
	x+= hsp;

	vsp += grv;
	
	//Y Collision
	if (place_meeting(x, y + vsp, oWall) || place_meeting(x, y + vsp, oSemiSolidWall)) {
	    while (!place_meeting(x, y + sign(vsp), oWall) && !place_meeting(x, y + sign(vsp), oSemiSolidWall)) {
	        y += sign(vsp);
	    }
		//Aca poner el codigo de que pasa cuando toca el piso, debe rebotar cada vez menos.
		vsp = max(vsp*-bounce_factor, -8);
		hsp=hsp*xFriction;
		
		// Si la velocidad es muy baja, detener el rebote
	    var min_bounce_speed = 1;
	    if (abs(vsp) < min_bounce_speed){
	        vsp = 0;
			hsp = 0;
	    }
	}
	y += vsp;
}