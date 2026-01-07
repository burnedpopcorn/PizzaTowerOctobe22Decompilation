image_xscale = 1;
hsp = floatdir * 5;
vsp = 0;
var ty = room_height * 0.25;
y = Approach(y, ty, 2);

if (place_meeting(x + floatdir, y, obj_solid))
    floatdir *= -1;

scr_collide();
