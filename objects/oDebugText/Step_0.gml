
debugKey = keyboard_check_pressed(ord("B")) + gamepad_button_check_pressed(0,gp_shoulderl);
debugKey = clamp(debugKey,0,1);

if debugKey{
	global.showDebug = !global.showDebug;	
}