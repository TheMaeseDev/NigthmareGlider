event_inherited();

function Destroy(){
	for(var i=8; i>=0;i--){
		instance_create_depth(x,y,depth,oSmallBox_Breaked);
	}
	instance_create_depth(x,y-(sprite_height/2),depth,oSmallBox_Smoke);
	cameraShake(1,5);
	instance_destroy();	
}

//Box Throwed Mechanic
grv = 0.275;

//Velocidades al ser lanzadas
throwHsp = 5;
throwVsp = -4;