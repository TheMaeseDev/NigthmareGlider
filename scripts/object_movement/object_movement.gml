/// object_movement(_hsp, _vsp, _grv, _face)
function object_movement(_hsp, _vsp, _grv, _face) {
    // Movimiento horizontal
	var _pixelCheck = 0.5 * sign(_hsp);
	if place_meeting(x+_hsp, y, oWall){
		while !place_meeting(x + _pixelCheck, y,oWall){
			x+=_pixelCheck;
		}
		_hsp = 0;
	}
	
	x+= _hsp *face;
	
	
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