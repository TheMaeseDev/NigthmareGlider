
/// Dispara una bomba y crea el efecto de humo
function fireBomb() {
    bombInstance = instance_create_depth(x+20*face, y+2, depth, oBomb);
	hasShoot = true;
    with (bombInstance) {
        face = other.face;
        flying = true;
        timerStart = true;
    }
    
    // Crear efecto de humo
    var smoke = instance_create_depth(x+(11*face), y-13, depth - 1, oEnemy_Cannon_Fire_Effect);
	with smoke self.image_xscale = -other.face;
}

//Variables del Cannon
hp = 2;
hspDefault = 0;
hsp = hspDefault;
face = -1;
hsp = 0;
vsp = 0;
grv = 0.275;
shootTimer = 60; //Cuenta regresiva para disparar
shootFrames = 360; //Intervalo de disparo
shootMinDelay = 90;
hasShoot = false;

invulnerable = false;
invulnTimer = 0;
blinkTimer = 0;
maxBlinkTimer = 0;
blinkSpeed = 5;

bombInstance = noone; //Ultima bomba creada
state = "idle" //Estado inicial
frameToShoot = 4; //Frame exacto donde se dispara