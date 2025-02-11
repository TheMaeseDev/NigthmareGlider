function bounce_behaviour(_hsp,_vsp,_grv,_face,_bounceFactor,_xFriction){
	//X collision
	var _subPixel = .5;
	if place_meeting(x+_hsp, y, oWall){
		//First check if there is a slope to go up
		if !place_meeting(x+_hsp,y-abs(_hsp)-1,oWall){
			while place_meeting(x+_hsp,y,oWall){ y-=_subPixel};
		}
		//Next, check for ceiling slopes, otherwise, do a regular collision
		else{
			//Ceiling Slopes
			if(!place_meeting(x+_hsp,y+abs(_hsp)+1,oWall)){
				while place_meeting(x+_hsp,y,oWall) {y+= _subPixel}	
			}
			//Normal Collision
			else{
				//Scoot up to wall precisely
				var _pixelCheck = _subPixel * sign(_hsp);
				while !place_meeting(x + _pixelCheck, y,oWall){
					x+=_pixelCheck;
				}
				//Horizontal Bounce
				_hsp=-_hsp;
				_vsp-=1;
			}
		}	
	}
	x+= _hsp;

	_vsp += _grv;
	
	//Y Collision
	if (place_meeting(x, y + _vsp, oWall) || place_meeting(x, y + _vsp, oSemiSolidWall)) {
	    while (!place_meeting(x, y + sign(_vsp), oWall) && !place_meeting(x, y + sign(_vsp), oSemiSolidWall)) {
	        y += sign(_vsp);
	    }
		//Rebota cuando toca el piso y reduce aceleracion
		_vsp = max(_vsp*-_bounceFactor, -8);
		_hsp=_hsp*_xFriction;
		
		// Si la velocidad es muy baja, detener el rebote
	    var min_bounce_speed = 1;
	    if (abs(_vsp) < min_bounce_speed){
	        _vsp = 0;
			_hsp = 0;
	    }
	}
	y += _vsp;
	
	// Retornar las nuevas velocidades
	return [_hsp, _vsp];
}

