event_inherited()

color = c_fuchsia;
hp=2;

kby=3;
kbx=0;

enum ErizoState {
    Idle,    // Solo para el saltador
    Rolling, // Rodando con púas afuera (daño e invulnerabilidad)
    Stopped, // Momento de vulnerabilidad tras frenar
    Jumping,  // Solo para el saltador
	JumpAttack,
	Hit
};

// Tipos de comportamiento
is_roller = false;  // Rodador
is_jumper = true;  // Saltador vertical
is_jump_attacker = false; // Nuevo: Salto en parábola

if (is_jumper) {
    is_roller = false;
    is_jump_attacker = false;
} else if (is_roller) {
    is_jumper = false;
    is_jump_attacker = false;
} else if is_jump_attacker{
    is_roller = false;
    is_jumper = false;
}else {
    is_roller = false;
    is_jumper = true; // Si ninguna es true, se asigna por defecto a este
    is_jump_attacker = false;
}

// Variables de movimiento
hsp = 0;
vsp = 0;
face = 1; // Dirección inicial

// Velocidades
roll_speed = 4;
jump_power = -6;
jump_attack_hsp = 2;
jump_attack_vsp = -7;

// Temporizadores
stopped_frames = 90;
stopped_timer = stopped_frames;
jump_timer = stopped_frames;

canTakeDamage = true;

// saltar a la posicion inicial
horJumpsFrames=3;
horJumpsCount = horJumpsFrames;
needToReturn=false;


// Estado inicial
if (is_roller) {
    state = ErizoState.Rolling;
} else if (is_jumper) {
    state = ErizoState.Idle;
} else if (is_jump_attacker) {
    state = ErizoState.Idle;
}