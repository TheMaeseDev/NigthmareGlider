event_inherited();

// Aplicamos el movimiento
//y = startY + sin(timer) * rangeY;
y = lerp(y, startY + sin(timer) * rangeY, 0.1);

// Incrementamos el timer gradualmente
timer += 0.05;

// Incrementamos el timer con un límite
//timer = (timer + 0.05) mod 360; OOOJOOOOO con esta linea, puede causar un overflow.

// Si llega al límite superior, empieza a bajar
if (y <= startY - rangeY) {
    vspd = abs(vspd); // Asegura que sea positivo para bajar
}

// Si llega al límite inferior, empieza a subir
if (y >= startY + rangeY) {
    vspd = -abs(vspd); // Asegura que sea negativo para subir
}

if instance_exists(oPlayer){
	if (x<oPlayer.x) face=1;
	if (x>oPlayer.x) face=-1;
}

image_xscale = face;