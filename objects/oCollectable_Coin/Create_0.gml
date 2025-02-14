event_inherited();

function Collected(){
	global.Player_Coins++;
	instance_create_depth(x,y,depth,oCollectable_Coin_Taked);
	instance_destroy();
}

behaviour=Behaviour.idle;

delayToBeTaked = 10;
canBeTaked = false;