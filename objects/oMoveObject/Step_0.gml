if !place_meeting(x,y+1,oWall) && !place_meeting(x,y+1,oSemiSolidWall){
	vsp += grv;
	
	if vsp>termVel{
		vsp = termVel;	
	}
}else{
	vsp = 0;	
}
y+=vsp;

if (place_meeting(x, y + 1, oWall)) {
    // Ajustar la posición justo encima del objeto colisionado
    while (!place_meeting(x, y, oWall)) {
        y += 1;
    }
    y -= 1;
}

var _objTop = instance_place(x,y-1,oMoveObject);

if _objTop!=noone{
	with(_objTop){
		//self.x = other.x;	
		//canMove=false;
	}
	canMove=false;
}
