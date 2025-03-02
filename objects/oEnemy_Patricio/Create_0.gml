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
is_jumper = false;  // Saltador vertical
is_jump_attacker = true; // Nuevo: Salto en parábola

// Variables de movimiento
hsp = 0;
vsp = 0;
face = 1; // Dirección inicial

// Velocidades
roll_speed = 4;
jump_power = -6;
jump_attack_hsp = 2;

// Temporizadores
stopped_frames = 90;
stopped_timer = stopped_frames;
jump_timer = stopped_frames;

canTakeDamage = true;

// Posición inicial (para volver a ella)
start_x = x;
start_y = y;


// Estado inicial
if (is_roller) {
    state = ErizoState.Rolling;
} else if (is_jumper) {
    state = ErizoState.Idle;
} else if (is_jump_attacker) {
    state = ErizoState.Idle;
}