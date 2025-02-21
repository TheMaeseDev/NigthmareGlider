event_inherited();

function Collected(){
	global.Player_Coins++;
	oHud.hud_timers[0] = 60 * 2; // Mostrar por 2 segundos
	instance_create_depth(x,y,depth,oCollectable_Coin_Taked);
	instance_destroy();
}

behaviour=Behaviour.idle;

delayToBeTaked = 10;
canBeTaked = false;