switch (state)
{
    case states.gottreasure:
        if (cutscenebuffer > 0)
            cutscenebuffer--;
        else
        {
            state = states.fall;
            instance_destroy(effectid);
        }
        
        break;
    
    case states.fall:
        var ty = playerid.y + 30;
        y = Approach(y, ty, movespeed);
        
        if (abs(y - ty) <= 50)
            movespeed = Approach(movespeed, 0, 0.1);
        
        if (y == ty || movespeed <= 0)
        {
            create_particle(x, y, particle.genericpoofeffect);
            scr_fmod_soundeffect(global.snd_collect, x, y);
            state = states.transitioncutscene;
            cutscenebuffer = 70;
            flamebuffer = 0;
            orangealpha = 1.5;
        }
        
        break;
    
    case states.transitioncutscene:
        if (orangealpha > 0)
            orangealpha -= 0.08;
        
        if (flamebuffer > 0)
            flamebuffer--;
        else
        {
            flamebuffer = 8;
            
            repeat (3)
                instance_create(x, y, obj_firemouthflame);
        }
        
        if (cutscenebuffer > 0)
            cutscenebuffer--;
        else
        {
            fmod_event_one_shot_3d("event:/sfx/pep/taunt", x, y);
            global.noisejetpack = true;
            
            with (playerid)
            {
                state = states.actor;
                sprite_index = choose(spr_supertaunt1, spr_supertaunt2, spr_supertaunt3, spr_supertaunt4);
                image_index = 0;
                image_speed = 0.35;
            }
            
            repeat (20)
            {
                with (obj_firemouthflame)
                {
                    hsp = 24;
                    vsp = 24;
                }
            }
            
            state = states.actor;
        }
        
        break;
    
    case states.actor:
        if (flamebuffer > 0)
            flamebuffer--;
        else
        {
            flamebuffer = 8;
            
            repeat (3)
            {
                with (instance_create(x, y, obj_firemouthflame))
                {
                    hsp *= 1.5;
                    vsp *= 1.5;
                }
            }
        }
        
        if (floor(playerid.image_index) == (playerid.image_number - 1))
        {
            playerid.state = states.normal;
            playerid.landAnim = false;
            playerid.flash = true;
            instance_destroy();
            create_transformation_tip(lang_get_value("jetpack2tip"), "jetpack2");
        }
        
        break;
}
