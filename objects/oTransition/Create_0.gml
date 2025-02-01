
enum states{
	OUT,
	IN
}

state = states.OUT;

spr = sTrans_sq;
sprW = sprite_get_width(spr);
sprH = sprite_get_height(spr);

//get number of sprites required
//set max sprites for X
xMax = room_width div sprW;
xMax = display_get_gui_width()*2 div sprW;

//set max sprites for Y
//yMax = room_height div sprH;
yMax = display_get_gui_height()*2 div sprH;

iMax = sprite_get_number(spr);

//set image speed

subImage_index_inc = sprite_get_speed(spr)/room_speed;
subImage_index = 0;

//Transition colour
col = c_black;

//Next room after transition
targetRoom = Room1;