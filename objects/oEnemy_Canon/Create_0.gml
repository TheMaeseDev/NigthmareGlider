
/// Dispara una bomba y crea el efecto de humo
function fireBomb() {
    bombInstance = instance_create_depth(x, y+2, depth, oBomb);
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
face = -1;
shootTimer = 60; //Cuenta regresiva para disparar
shootFrames = 360; //Intervalo de disparo
shootMinDelay = 90;
hasShoot = false;

bombInstance = noone; //Ultima bomba creada
state = "idle" //Estado inicial
frameToShoot = 4; //Frame exacto donde se dispara