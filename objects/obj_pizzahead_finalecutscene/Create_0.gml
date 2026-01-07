image_xscale = 1;
image_speed = 0.5;
vsp = 10;
state = states.jump;
superslam = false;
pizzahead_x = 0;
pizzahead_front = false;

if (room == boss_pizzafacefinale)
{
    image_speed = 2;
    vsp = -10;
    alarm[0] = 400;
}
