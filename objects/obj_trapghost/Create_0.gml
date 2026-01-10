if (instance_number(object_index) > 1)
{
    instance_destroy();
    exit;
}

alarm[0] = 1;
depth = 0;
image_alpha = 0;
target_alpha = 0.6;
alpha = false;
state = states.normal;
trapid = noone;
image_speed = 0.35;
