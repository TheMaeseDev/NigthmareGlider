

switch(state){
	case states.OUT:
		if subImage_index< iMax + xMax{
			subImage_index += subImage_index_inc;
		}else{
			state = states.IN
			global.Player_Hp = global.Player_HpMax;
			//goto room
			if room_exists(targetRoom) room_goto(targetRoom);
		}
	break;
	case states.IN:
		if subImage_index>0{
			subImage_index -= subImage_index_inc;
			global.Room_SpecialBox_Broken = 0;
			global.Room_SpecialBox = false;
		}else{
			instance_destroy();
		}
	break;
}

