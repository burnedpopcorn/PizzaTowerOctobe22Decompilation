instance_destroy(instance_place(x, y - 1, obj_baddie));

if (place_meeting(x, y - 1, obj_player))
{
    with (obj_player)
    {
        if (state != states.golf && state != states.tackle && state != states.gotoplayer)
        {
            if (place_meeting(x, y + 1, other))
            {
                if (state != states.trashjump && state != states.trashroll)
                {
                    if (state != states.barrel && state != states.barreljump && state != states.barrelslide && state != states.barrelclimbwall)
                    {
                        if (state != states.slipnslide || sprite_index != spr_currentplayer)
                            fmod_event_one_shot_3d("event:/sfx/misc/waterslidesplash", x, y);
                        
                        state = states.slipnslide;
                        sprite_index = spr_currentplayer;
                    }
                    else
                    {
                        state = states.barrelslide;
                        
                        if (sprite_index != spr_player_barrelslipnslide)
                            sprite_index = spr_player_barrelroll;
                    }
                    
                    xscale = sign(other.image_xscale);
                    movespeed = 20;
                }
                else
                {
                    with (instance_create(x, y, obj_slidecloud))
                    {
                        fmod_event_one_shot_3d("event:/sfx/misc/waterslidesplash", x, y);
                        image_xscale = other.xscale;
                        sprite_index = spr_watereffect;
                    }
                    
                    vsp = -6;
                    image_index = 0;
                    
                    if (state == states.trashjump)
                    {
                        state = states.trashroll;
                        movespeed = abs(movespeed);
                        dir = xscale;
                        movespeed += 3;
                        instance_create(x, y, obj_jumpdust);
                        sprite_index = spr_player_trashslide;
                    }
                }
            }
        }
    }
}
