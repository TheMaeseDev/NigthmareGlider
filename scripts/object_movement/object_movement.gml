/// object_movement(_hsp, _vsp, _grv, _face)
function object_movement(_hsp, _vsp, _grv, _face) {
    
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
				//Set xspd to zero to "collide"
				_hsp = 0;
			}
		}	
	}
	
	x+= _hsp*face;
	
    // Aplicar gravedad
    _vsp += _grv;

    // Colisión vertical
    if place_meeting(x, y + _vsp, oWall) || place_meeting(x, y + vsp, oSemiSolidWall) {
        while !place_meeting(x, y + sign(_vsp), oWall) && !place_meeting(x, y + sign(_vsp), oSemiSolidWall){
            y += sign(_vsp);
        }
        _vsp = 0; // Detener caída
    }

    // Aplicar movimiento vertical
    y += _vsp;
	

    // Retornar las nuevas velocidades
    return [_hsp, _vsp];
}