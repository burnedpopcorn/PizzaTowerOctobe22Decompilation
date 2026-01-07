with (instance_create(x, y, obj_explosioneffect))
{
    sprite_index = spr_bombexplosion;
    image_speed = 0.35;
}

if (bbox_in_camera(view_camera[0], 78))
{
    GamepadSetVibration(0, 1, 1, 0.9);
    GamepadSetVibration(1, 1, 1, 0.9);
    fmod_event_one_shot_3d("event:/sfx/misc/explosion", x, y);
}

with (baddieID)
{
    if (bombreset > 20)
        bombreset = 20;
}
