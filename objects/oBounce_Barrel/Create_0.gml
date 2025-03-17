function bounceBehaviour(_hsp,_vsp,_grv,_face,_bounceFactor,_xFriction){
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
				//Stop X collision
				_hsp=0;
				Destroy();
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
		_vsp = bounceHeight;
		_hsp=_hsp*_xFriction;
	}
	y += _vsp;
	// Retornar las nuevas velocidades
	return [_hsp, _vsp];
}
	
function Destroy(){
	for(var i=8; i>=0;i--){
		instance_create_depth(x,y,depth,oSmallBox_Breaked);
	}
	instance_create_depth(x,y-(sprite_height/2),depth,oSmallBox_Smoke);
	cameraShake(3,5);
	instance_destroy();	
}

//Variables de movimiento
hspDefault = 2;
vspDefault = 0;
hsp = hspDefault;
vsp = vspDefault;
grv = 0.25;
xFriction = 1; //Reduccion de velocidad horizontal
bounceFactor = 1;
face = 1;
bounceHeight = -4;

//Velocidades al ser lanzadas
throwHsp = 4.5;
throwVsp = -4.5;