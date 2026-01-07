function scr_dotaunt()
{
    if (key_taunt2 || input_finisher_buffer > 0 || (state == states.backbreaker && key_up && supercharged))
    {
        input_finisher_buffer = 0;
        pistolanim = -4;
        
        if (place_meeting(x, y, obj_exitgate) && global.panic == true && global.combotime > 0)
        {
            global.collect += 25;
            
            with (instance_create(x + 16, y, obj_smallnumber))
                number = string(25);
            
            create_collect(x, y, spr_taunteffect);
            scr_fmod_soundeffect(global.snd_collect, x, y);
        }
        
        if (!finisher)
        {
            fmod_event_one_shot_3d("event:/sfx/pep/taunt", x, y);
            taunttimer = 20;
            
            if (state != states.backbreaker)
            {
                tauntstoredmovespeed = movespeed;
                tauntstoredvsp = vsp;
                tauntstoredsprite = sprite_index;
                tauntstoredstate = state;
            }
            
            state = states.backbreaker;
            
            if (supercharged && key_up)
            {
                image_index = 0;
                sprite_index = choose(spr_supertaunt1, spr_supertaunt2, spr_supertaunt3, spr_supertaunt4);
                
                if (isgustavo)
                    sprite_index = spr_player_ratmountsupertaunt;
            }
            else
            {
                taunttimer = 20;
                sprite_index = spr_taunt;
                image_index = random_range(0, 11);
            }
            
            with (instance_create(x, y, obj_taunteffect))
                player = other.id;
        }
    }
}
