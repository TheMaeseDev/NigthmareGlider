
for (var _yy = 0; _yy <= yMax; ++_yy) {
    for (var _xx = 0; _xx <= yMax; ++_xx){
		draw_sprite_ext(spr,min(max(0,subImage_index-_xx),iMax-1),_xx*sprW,_yy*sprH,1,1,0,col,1);
	}
}