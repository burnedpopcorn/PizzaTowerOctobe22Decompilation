hsp = 0;
vsp = 0;
hsp_carry = 0;
vsp_carry = 0;
grav = 0.5;
platformid = -4;
image_speed = 0.35;
introstate = 0;
introbuffer = 0;
peppermanid = -4;
prop = 0;
proparr = [[1143, 3547, 3062, -7], [2755, 2766, 861, -6], [1190, 1108, 861, -5], [3425, 1425, 861, -4]];

with (obj_music)
    fmod_event_instance_set_parameter(music.event, "state", 2, false);
