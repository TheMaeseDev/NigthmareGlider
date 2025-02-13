event_inherited();

function Collected(){
	oPlayer.coins++;
	instance_destroy();
}

behaviour=Behaviour.idle;

delayToBeTaked = 10;
canBeTaked = false;