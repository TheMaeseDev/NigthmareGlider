event_inherited();

function Collected(){
	oPlayer.Lives++;
	instance_destroy();
}

behaviour=Behaviour.idle;