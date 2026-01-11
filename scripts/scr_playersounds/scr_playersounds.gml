function scr_playersounds()
{
    with (obj_player)
    {
        if (state == states.mach2 || state == states.mach3 || state == states.climbwall || state == states.rocket)
        {
            if (!fmod_event_instance_is_playing(machsnd))
                fmod_event_instance_play(machsnd);
            
            var s = 0;
            
            if (state == states.mach2 && sprite_index == spr_mach1 && grounded)
                s = 1;
            else if ((state == states.mach2 && sprite_index == spr_mach) || state == states.climbwall)
                s = 2;
            else if (state == states.mach3 && sprite_index != spr_crazyrun)
                s = 3;
            else if (sprite_index == spr_crazyrun)
                s = 4;
            
            if (state == states.rocket)
                s = 4;
            
            fmod_event_instance_set_3d_attributes(machsnd, x, y);
            fmod_event_instance_set_parameter(machsnd, "state", s, true);
        }
        else
        {
            fmod_event_instance_set_parameter(machsnd, "state", 0, true);
            
            if (fmod_event_instance_is_playing(machsnd))
                fmod_event_instance_stop(machsnd, true);
        }
        
        if (state == states.knightpepslopes && grounded && vsp > 0)
        {
            if (!fmod_event_instance_is_playing(knightslidesnd))
                fmod_event_instance_play(knightslidesnd);
            
            fmod_event_instance_set_3d_attributes(knightslidesnd, x, y);
        }
        else if (fmod_event_instance_is_playing(knightslidesnd))
            fmod_event_instance_stop(knightslidesnd, true);
        
        if (state == states.Sjumpprep)
        {
            if (!fmod_event_instance_is_playing(superjumpsnd))
            {
                fmod_event_instance_set_parameter(superjumpsnd, "state", 0, true);
                fmod_event_instance_play(superjumpsnd);
            }
        }
        else if (state == states.Sjump)
            fmod_event_instance_set_parameter(superjumpsnd, "state", 1, true);
        else if (state != states.Sjump)
        {
            if (fmod_event_instance_is_playing(superjumpsnd) && fmod_event_instance_get_parameter(superjumpsnd, "state") < 1)
                fmod_event_instance_stop(superjumpsnd, true);
            else if (!fmod_event_instance_is_playing(superjumpsnd))
                fmod_event_instance_set_parameter(superjumpsnd, "state", 0, true);
        }
        
        if (fmod_event_instance_is_playing(superjumpsnd))
            fmod_event_instance_set_3d_attributes(superjumpsnd, x, y);
        
        if (sprite_index == spr_tumblestart || sprite_index == spr_tumble || sprite_index == spr_machroll)
        {
            if (!fmod_event_instance_is_playing(tumblesnd))
            {
                fmod_event_instance_play(tumblesnd);
                fmod_event_instance_set_parameter(tumblesnd, "state", 0, true);
                
                if (sprite_index == spr_tumblestart)
                    tumbleintro = true;
            }
            
            if ((sprite_index == spr_tumble && !tumbleintro) || sprite_index == spr_machroll)
                fmod_event_instance_set_parameter(tumblesnd, "state", 1, true);
            
            fmod_event_instance_set_3d_attributes(tumblesnd, x, y);
        }
        else
        {
            if (fmod_event_instance_is_playing(tumblesnd))
            {
                fmod_event_instance_set_parameter(tumblesnd, "state", 2, true);
                fmod_event_instance_set_3d_attributes(tumblesnd, x, y);
            }
            
            tumbleintro = false;
        }
        
        if (fmod_event_instance_is_playing(suplexdashsnd))
        {
            if (state != states.handstandjump)
                fmod_event_instance_stop(suplexdashsnd, true);
            
            fmod_event_instance_set_3d_attributes(suplexdashsnd, x, y);
        }
        
        if (state == states.trashroll && sprite_index == spr_player_corpsesurf && grounded && vsp > 0)
        {
            if (!fmod_event_instance_is_playing(gravecorpsesnd))
                fmod_event_instance_play(gravecorpsesnd);
            
            fmod_event_instance_set_3d_attributes(gravecorpsesnd, x + hsp, y + vsp);
        }
        else
            fmod_event_instance_stop(gravecorpsesnd, true);
        
        if (state == states.barrelslide && grounded && vsp > 0)
        {
            if (!fmod_event_instance_is_playing(barrelslidesnd))
                fmod_event_instance_play(barrelslidesnd);
            
            fmod_event_instance_set_3d_attributes(barrelslidesnd, x + hsp, y + vsp);
        }
        else
            fmod_event_instance_stop(barrelslidesnd, true);
        
        if (state == states.slipnslide && sprite_index == spr_currentplayer)
        {
            if (!fmod_event_instance_is_playing(waterslidesnd))
                fmod_event_instance_play(waterslidesnd);
            
            fmod_event_instance_set_3d_attributes(waterslidesnd, x + hsp, y + vsp);
        }
        else
            fmod_event_instance_stop(waterslidesnd, true);
    }
}
