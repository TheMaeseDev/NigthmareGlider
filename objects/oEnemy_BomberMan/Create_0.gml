event_inherited();

enum EnemyState {
    Idle,
	Walk,
    Angry,
	Back,
	Attack
}

function throwBomb(bombHsp,bombVsp,xValue,yValue){
	var bomb = instance_create_depth(xValue,yValue-27,depth,oBomb);
	bomb.estado = States.Flying;
	bomb.timerStart = true;
	bomb.timerFrames=60;
	bomb.hsp = bombHsp;
	bomb.vsp = bombVsp;
}

function prepareBomb(){
	BombTimer--;
	if BombTimer<=0{
		state=EnemyState.Attack;
		throwBomb(bombHsp*sign(oPlayer.x - x),bombVsp,x,y);
		BombTimer=bombFrames;
	}
}

hp=3;
color = c_red;
knockback=true;


//Que hace cuando le pegan?
revenge=false;
wasInvulnerable = false;

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
bombFrames=150;
lookDirection = 1;
bombHsp=1.5;
bombVsp=-4;

