enum EnemyState {
    Idle,
	Walk,
    Angry,
	Back
}

function throwBomb(bombHsp,bombVsp){
	var bomb = instance_create_depth(x,y-20,depth,oBomb);
	bomb.estado = States.Flying;
	bomb.timerStart = true;
	bomb.timerFrames=150;
	bomb.hsp = bombHsp;
	bomb.vsp = bombVsp;
}

function prepareBomb(){
	BombTimer--;
	if BombTimer<=0{
		throwBomb(bombHsp*sign(oPlayer.x - x),bombVsp);
		BombTimer=bombFrames;
	}
}

//Manejo de Sprites
sprIdle = sEnemy_BomberMan_Idle;
sprWalk = sEnemy_BomberMan_Run;
sprHit = sEnemy_BomberMan_Hit;
sprAttack= sEnemy_BomberMan_Attack;

state = EnemyState.Idle;
runSpeed=1.8;
runSpeed2=3;
hsp = 0;
newHsp=2;
hspBase = 2;
face = 1;
vsp = 0;
grv = 0.5;
hspDer=1;
hspIzq=-1;

idlePauseTimer = 0;
idlePauseFrames = 180;
initialDistance = 100;

minPlayerDistance = 125;
maxPlayerDistance = 250;
xStart = x;

BombTimer = 30;
bombFrames=180;
lookDirection = 1;
bombHsp=6;
bombVsp=-4.5;