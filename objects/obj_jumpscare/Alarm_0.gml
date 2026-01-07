state++;

if (state == 1)
{
    fmod_event_one_shot("event:/sfx/misc/jumpscare");
    alarm[0] = 100;
    instance_destroy(obj_kidspartybg);
    instance_destroy(obj_bazooka);
    
    with (obj_monster)
    {
        x = xstart;
        y = ystart;
        xscale = 1;
        yscale = 1;
        
        if (grav < 0)
            grav *= -1;
        
        state = UnknownEnum.Value_217;
        event_perform(ev_other, ev_room_start);
    }
    
    with (obj_monstergate)
    {
        active = false;
        instance_activate_object(solidID);
        y = ystart;
    }
    
    with (obj_camerapatrol)
    {
        alarm[5] = -1;
        patrolfound = false;
    }
    
    with (obj_patroller)
    {
        alarm[5] = -1;
        patrolfound = false;
    }
}
else if (state == 2)
{
    sprite_index = spr_tvstatic;
    image_index = sprite_get_number(spr_tvstatic) - 1;
    image_speed = 0;
    
    with (obj_player)
    {
        if (check_player_coop())
        {
            state = states.animatronic;
            x = roomstartx;
            y = roomstarty;
        }
    }
    
    warbg_stop();
}
