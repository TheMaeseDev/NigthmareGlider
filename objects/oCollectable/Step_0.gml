
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
				face= -face;
				vsp+=0.5;
				hsp+=0.5;
			}
		}	
	}
	
	x+= hsp*face;

	vsp += grv;
	
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
	}
	
	//Y Collision
	if (place_meeting(x, y + vsp, oWall) || place_meeting(x, y + vsp, oSemiSolidWall)) {
	    while (!place_meeting(x, y + sign(vsp), oWall) && !place_meeting(x, y + sign(vsp), oSemiSolidWall)) {
	        y += sign(vsp);
	    }
	    vsp = 0;
	}
	y += vsp;
}

global.mensaje=hsp*face;