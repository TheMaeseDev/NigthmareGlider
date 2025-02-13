event_inherited();

function Collected(){
	global.Player_Coins++;
	instance_destroy();
}

behaviour=Behaviour.idle;

delayToBeTaked = 10;
canBeTaked = false;