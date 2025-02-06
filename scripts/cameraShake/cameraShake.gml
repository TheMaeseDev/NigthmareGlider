// SCRIPT: cameraShake


/// @function cameraShake(magnitude, duration)
/// @param magnitude - Intensidad del temblor (ej: 2 = leve, 10 = fuerte)
/// @param duration  - Cuántos frames durará el temblor
/// @description Agrega un temblor a la cámara según la magnitud indicada

/// Variables globales para la sacudida
global.shakeMagnitude = argument0;
global.shakeDuration = argument1;
global.shakeTimer = global.shakeDuration;