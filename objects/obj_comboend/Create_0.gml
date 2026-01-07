combo = 0;
comboscore = 0;
combominus = 0;
timer_max = 1;
timer = 0;
title_index = 0;
depth = obj_particlesystem.depth - 1;
alarm[0] = 1;
x = 832;
y = 197;
depth = -300;

with (obj_player)
{
    if (!place_meeting(x, y, obj_exitgate))
        global.combodropped = true;
}
