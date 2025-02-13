event_inherited();

function Collected(){
	global.Player_Lives = min(global.Player_Lives + 3, global.Player_LivesMax);
	instance_destroy();
}

behaviour=Behaviour.idle;