image_speed = 0.1;

if (instance_number(object_index) > 1)
{
    instance_destroy();
    exit;
}

global.pigtotal = 0;
global.pigreduction = 0;
world = 1;
alarm[0] = 1;
