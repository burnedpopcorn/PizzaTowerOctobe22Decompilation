if (state == states.normal)
{
    savedsprite = sprite_index;
    savedindex = image_index;
    vsp = -2;
    sprite_index = spr_titlepep_punch;
    image_index = irandom(sprite_get_number(sprite_index) - 1);
    image_speed = 0;
    alarm[1] = 20;
    fmod_event_one_shot_3d("event:/sfx/misc/cowkick", room_width / 2, room_height / 2);
    
    repeat (5)
    {
        with (create_debris(mouse_x, mouse_y, spr_slapstar))
            vsp = -irandom_range(8, 11);
    }
    
    repeat (5)
    {
        with (create_debris(mouse_x, mouse_y, spr_baddiegibs))
            vsp = -irandom_range(8, 11);
    }
}
