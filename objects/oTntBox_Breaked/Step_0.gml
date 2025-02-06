
image_angle+=rotationSpeed;
image_alpha -= alphaSpeed;

if(image_alpha<0) instance_destroy();

vsp+=grv;
y+=vsp;
x+=hsp;