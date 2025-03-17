
// Chequeo de colisión con cada lado del bloque sólido
var touchingTop    = place_meeting(x,y-1,oPlayer);
var touchingBottom = place_meeting(x,y+1,oPlayer);
var touchingLeft   = place_meeting(x+1,y,oPlayer);
var touchingRight  = place_meeting(x-1,y,oPlayer);

if (touchingTop || touchingBottom || touchingLeft || touchingRight) {
	oPlayer.takeDamage(2,x);
}