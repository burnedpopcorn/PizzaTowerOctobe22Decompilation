if (grounded && vspeed == 10)
    instance_destroy();

if (ANIMATION_ENDED)
{
    vspeed = 10;
    image_speed = 0;
}
