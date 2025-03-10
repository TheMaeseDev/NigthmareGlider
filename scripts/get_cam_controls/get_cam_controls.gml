function get_cam_controls(){
	//Camera inputs
	var camStickValue = gamepad_axis_value(0, gp_axisrh);
	var camStickVertical = gamepad_axis_value(0, gp_axisrv);

	camRightKey = keyboard_check(vk_right);
	if (camStickValue > 0.2) camRightKey += camStickValue;
		camRightKey = clamp(camRightKey,0,1);
	
	camLeftKey = keyboard_check(vk_left);
	if (camStickValue < -0.2) camLeftKey += abs(camStickValue);
		camLeftKey = clamp(camLeftKey,0,1);
		
	camUpKey = keyboard_check(vk_up);
	if (camStickVertical < -0.2) camUpKey += abs(camStickVertical);
		camUpKey = clamp(camUpKey,0,1);
		
	camDownKey = keyboard_check(vk_down);
	if (camStickVertical > 0.2) camDownKey += camStickVertical;
		camDownKey = clamp(camDownKey,0,1);
}