
vsp += grv;

if (place_meeting(x, y + vsp, oWall) || place_meeting(x, y + vsp, oSemiSolidWall)) {
    while (!place_meeting(x, y + sign(vsp), oWall) && !place_meeting(x, y + sign(vsp), oSemiSolidWall)) {
        y += sign(vsp);
    }
    vsp = 0;
}

y += vsp;

objTop = instance_place(x,y-1,oMoveObject);

if !instance_place(x+(1*face),y,oWall){
	canMove = true;	
}else canMove = false;

