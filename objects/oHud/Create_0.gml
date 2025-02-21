
//Controlar animacion de Hud

// Estados de visibilidad
hud_visible = false; // Si está activo todo el HUD
hud_timer = 0; // Cuenta regresiva para ocultar cada elemento

// Timers individuales para cada elemento
hud_timers = array_create(6, 0); // Monedas, Vidas, Healthbar, Cajas, Mapas, Power

// Posiciones fuera de la pantalla
hud_offscreen_y = [
    -50, // Monedas (arriba)
    -50, // Healthbar (arriba)
    -50, // Vidas (arriba)
    room_height + 50, // Cajas (abajo)
    room_height + 50, // Mapas (abajo)
    room_height + 50  // Power (abajo)
];

// Posiciones visibles (se asignan en el Draw)
hud_target_y = array_create(6, 0);

depth=-1000;
transparencia = 0.8; // Transparencia de los íconos (0 = invisible, 1 = sólido)

map_merge_progress = 0; // Progreso de animación (0 = sin juntar, 1 = completo)
map_animation_speed = 0.025; // Velocidad de la animación


map_sprites = [
    sCollectable_MapPiece0,
    sCollectable_MapPiece1,
    sCollectable_MapPiece2,
    sCollectable_MapPiece3
];