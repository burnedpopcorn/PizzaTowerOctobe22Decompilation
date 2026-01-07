with (instance_create(x, y, obj_canonexplosion))
{
    sprite_index = spr_dynamiteexplosion;
    image_speed = 0.35;
}

with (instance_create(x + (image_xscale * 80), y + 10, obj_lightsource_expand))
{
    distance = 300;
    accel = 15;
}
