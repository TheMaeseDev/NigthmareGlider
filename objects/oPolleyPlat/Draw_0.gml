var ancho_bloques = (bbox_right-bbox_left+1) div 16;

//Punta izquierda
draw_sprite(sSolidPlatform1,0,x,y);

//Medio
for(var i=1;i<ancho_bloques-1;i++){
	draw_sprite(sSolidPlatform1,1,x+i*16,y);
}

//Punta derecha
draw_sprite(sSolidPlatform1,2,x+(ancho_bloques-1)*16,y);

// Configurar el color y la alineación del texto
draw_set_color(c_white);  
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

mensajeLoco = yspd;
// Dibujar el número de vida sobre el enemigo
if global.showDebug{
	draw_text(x, y-sprite_height*1.5, mensajeLoco);
}

// Variable para activar/desactivar el dibujo de los cables
if (!showCables) exit; // Si la variable es falsa, no dibuja nada

// Posición de esta plataforma
var x1 = x + sprite_width / 2;
var y1 = y;

// Posición del anclaje (topLimit)
var x2 = x1;
var y2 = topLimit-7;

// Grosor de la línea
var thickness = 2;

// Dibujar la "cuerda" vertical (DEBE IR PRIMERO)
draw_set_color(c_black);
draw_rectangle(x1 - thickness / 2, y1, x2 + thickness / 2, y2, false);

// Dibujar la línea entre plataformas (también debe estar atrás)
if (pairedPlatform != noone) {
    var x3 = pairedPlatform.x + pairedPlatform.sprite_width / 2;
    var y3 = pairedPlatform.topLimit-7;

    draw_set_color(c_black);
    draw_rectangle(x2 - thickness / 2, y2 - thickness / 2, x3 + thickness / 2, y3 + thickness / 2, false);
}

// Dibujar el punto rojo de ESTA plataforma (AHORA QUEDA AL FRENTE)
draw_set_color(c_red);
draw_circle(x2, y2, 4, false);

// Dibujar el punto rojo de la PLATAFORMA PAREADA (SI EXISTE)
if (pairedPlatform != noone) {
    var x3 = pairedPlatform.x + pairedPlatform.sprite_width / 2;
    var y3 = pairedPlatform.topLimit-7;
    
    draw_set_color(c_red);
    draw_circle(x3, y3, 4, false);
}