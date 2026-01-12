mask_index = spr_pepperman_statues1;

if (hitLag <= 0)
    scr_collide();
else
{
    x = hitX + irandom_range(-4, 4);
    y = hitY + irandom_range(-4, 4);
    hitLag--;
    
    if (hitLag <= 0)
    {
        x = hitX;
        y = hitY;
    }
}

if (!fall && grounded && vsp > 0)
{
    fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y);
    fall = true;
    
    with (obj_camera)
    {
        shake_mag = 3;
        shake_mag_acc = 5 / room_speed;
    }
}

if (contemplated)
{
    with (obj_pepperman)
    {
        if (state != states.contemplate)
            instance_destroy(other);
    }
}

image_index = round(maxhp - hp);
