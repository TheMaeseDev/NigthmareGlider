enum EnemyState {
    Idle,
	Walk,
    Raway,
	isAway,
	Trapped,
	Attack
}

function throwBomb(bombHsp,bombVsp){
	var bomb = instance_create_depth(x,y,depth,oBomb);
	bomb.estado = States.Flying;
	bomb.timerStart = true;
	bomb.hsp = bombHsp;
	bomb.vsp = bombVsp;
}

//Manejo de Sprites
sprIdle = sEnemy_BomberMan_Idle;
sprWalk = sEnemy_BomberMan_Run;
sprHit = sEnemy_BomberMan_Hit;
sprAttack= sEnemy_BomberMan_Attack;

state = EnemyState.Idle;

hsp = 0;
hspBase = 2;
face = 1;
vsp = 0;
grv = 0.5;

idlePauseTimer = 0;
idlePauseFrames = 180;
initialDistance = 100;

minPlayerDistance = 125;
maxPlayerDistance = 150;
xStart = x;

BombTimer = 120;