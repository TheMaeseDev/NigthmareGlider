event_inherited()

color = c_fuchsia;
hp=2;

kby=3;
kbx=0;

enum ErizoState {
    Idle,    // Solo para el saltador
    Rolling, // Rodando con púas afuera (daño e invulnerabilidad)
    Stopped, // Momento de vulnerabilidad tras frenar
    Jumping  // Solo para el saltador
};

// Definir si es "Rodador" o "Saltador"
is_roller = false; // Cambiar a false si es un saltador

// Variables de movimiento
hsp = 0;
vsp = 0;
face = 1; // Dirección inicial

// Velocidades
roll_speed = 4;
jump_power = -6;

// Temporizadores
stopped_frames = 90;
stopped_timer = stopped_frames;
jump_timer = stopped_frames;


// Estado inicial
state = is_roller ? ErizoState.Rolling : ErizoState.Idle;