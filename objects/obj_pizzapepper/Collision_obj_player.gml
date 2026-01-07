if (visible == true)
{
    scr_soundeffect(global.snd_collect, x, y);
    visible = false;
    gotowardsplayer = false;
    
    repeat (6)
    {
        with (instance_create(x + random_range(-40, 40), y + random_range(-40, 40), obj_parryeffect))
            sprite_index = spr_heatpuff;
    }
    
    with (other)
    {
        vsp = -14;
        state = states.jetpackjump;
        sprite_index = spr_player_jetpackstart;
        doublejump = false;
        
        with (instance_create(x, y, obj_highjumpcloud2))
            sprite_index = spr_player_firemouthjumpdust;
        
        with (instance_place(x, y - 34, obj_iceblock_breakable))
        {
            instance_destroy();
            
            if (other.vsp < 0)
                other.vsp = -14;
            else if (other.vsp > -11)
                other.vsp = -11;
            
            jumpstop = false;
        }
    }
    
    timetovisible = 100;
}
