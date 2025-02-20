var ancho_bloques = (bbox_right-bbox_left+1) div 16;

//Punta izquierda
draw_sprite(sPlatform1,0,x,y);

//Medio
for(var i=1;i<ancho_bloques-1;i++){
	draw_sprite(sPlatform1,1,x+i*16,y);
}

//Punta derecha
draw_sprite(sPlatform1,2,x+(ancho_bloques-1)*16,y);