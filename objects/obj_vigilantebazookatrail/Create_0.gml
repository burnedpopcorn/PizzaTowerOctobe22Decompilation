event_inherited();
alarm[0] = 5;

with (instance_create(x + (image_xscale * 80), y + 10, obj_lightsource_expand))
{
    distance = 600;
    accel = 20;
}
