event_inherited();

function Collected(){
	global.Player_Coins++;
	global.hud_active[0] = true; // Activa la moneda
	global.hud_timer[0] = 60 * 2; // Se queda 2 segundos en pantalla
	instance_create_depth(x,y,depth,oCollectable_Coin_Taked);
	instance_destroy();
}

behaviour=Behaviour.idle;

delayToBeTaked = 10;
canBeTaked = false;