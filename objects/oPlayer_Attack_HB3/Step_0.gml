
durationFrames--;
if(durationFrames<=0) instance_destroy();

//Colisiones
if instance_place(x,y,oSmallBox) 
|| instance_place(x,y,oEnemyBase)
|| instance_place(x,y,oBomb)
|| instance_place(x,y,oBomb_Explosion)
{
	instance_destroy();
}