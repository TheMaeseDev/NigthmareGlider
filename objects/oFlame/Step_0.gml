
// Aparece y desaparece gradualmente
if (instance_exists(oFlamethrower) && oFlamethrower.active) {
    if (image_alpha < 1) image_alpha += fade_speed;
} else {
    image_alpha -= fade_speed;
    if (image_alpha <= 0) instance_destroy();
}