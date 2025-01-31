function controlsSetup(){
	bufferTime = 5;
	jumpKeyBuffered = 0;
	jumpKeyBufferTimer = 0;
	
	airAttackBufferTime = 7;
	airAttackBuffered = 0;
	airAttackBufferTimer = 0;
}


function getControls(){
	//Directions inputs
	var stickValue = gamepad_axis_value(0, gp_axislh);
	var stickVertical = gamepad_axis_value(0, gp_axislv);

	rightKey = keyboard_check(vk_right) + keyboard_check(ord("D")) + gamepad_button_check(0,gp_padr);
	if (stickValue > 0.2) rightKey += stickValue;
		rightKey = clamp(rightKey,0,1);
	
	leftKey = keyboard_check(vk_left) + keyboard_check(ord("A")) + gamepad_button_check(0,gp_padl);
	if (stickValue < -0.2) leftKey += abs(stickValue);
		leftKey = clamp(leftKey,0,1);
	
	downKey = keyboard_check(vk_down) + keyboard_check(ord("S")) + gamepad_button_check(0,gp_padd);
	if (stickVertical > 0.5) downKey += stickVertical;
		downKey = clamp(downKey,0,1);
	
	//Actions inputs
	jumpKeyPressed = keyboard_check_pressed(vk_space) + gamepad_button_check_pressed(0,gp_face1);
		jumpKeyPressed = clamp(jumpKeyPressed,0,1);
	jumpKey = keyboard_check(vk_space) + gamepad_button_check(0,gp_face1);
		jumpKey = clamp(jumpKey,0,1);
		
	runKey = keyboard_check(vk_shift) + gamepad_button_check(0,gp_shoulderr);
		runKey = clamp(runKey,0,1);
		
	attackKey = keyboard_check_pressed(ord("K")) + gamepad_button_check_pressed(0,gp_face3);
		attackKey = clamp(attackKey,0,1);
	
	glideKey = keyboard_check(vk_control) + gamepad_button_check(0,gp_face4);
		glideKey = clamp(glideKey,0,1);
		
	//Miscellaneous inputs
	restartKey = keyboard_check_pressed(ord("R")) + gamepad_button_check_pressed(0,gp_select);
		restartKey = clamp(restartKey,0,1);
		
	//Jump Key Buffering
	if(jumpKeyPressed) jumpKeyBufferTimer = bufferTime;
	
	if(jumpKeyBufferTimer>0){
		jumpKeyBuffered=1;
		jumpKeyBufferTimer--;
	} else{
		jumpKeyBuffered = 0;
	}
	
	//Air Attack Buffering
	if (attackKey) airAttackBufferTimer = airAttackBufferTime;
	
	if (airAttackBufferTimer>0){
		airAttackBuffered=1;
		airAttackBufferTimer--;
	}else{
		airAttackBuffered  = 0;
	}
}