event_inherited();

function Collected(){
	global.Player_Hp = min(global.Player_Hp + 3, global.Player_HpMax);
	instance_create_depth(x,y,depth,oCollectable_Heal_Taked);
	instance_destroy();
}

behaviour=Behaviour.bounce;