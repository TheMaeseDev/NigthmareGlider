
function enemyDestroy(){
	instance_destroy();
	with instance_create_depth(x,y-(sprite_height/2),depth,oSmallBox_Smoke) image_blend = other.color;
}

knockback = true;
state=noone;
hp = 1;
hspDefault = 0;
hsp = hspDefault;
vsp = 0;
grv = 0.275;
face = 1;

invulnerable = false;
invulnTimer = 0;
blinkTimer = 0;
maxBlinkTimer = 0;
blinkSpeed = 5;

canAttack = true;
canAttackFrames = 20;
canAttackTimer = 0;

sprHitted = noone;
sprDead = noone;

color = c_white;

isFlying = false;
