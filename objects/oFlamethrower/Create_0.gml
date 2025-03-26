// Configuración del lanzallamas
fire_length = 128; // Longitud máxima del fuego (múltiplo de 16)
fire_direction = 45; // Dirección (0=Derecha, 90=Arriba, 180=Izquierda, 270=Abajo)
fire_duration = 120; // Frames que permanece activo el fuego
fire_delay = 180; // Frames de espera entre cada activación
fire_step = 16; // Expansión/retracción del fuego por frame

// Estado del lanzallamas
fire_timer = fire_delay;
active = false;
current_length = 0;
