if (state != states.grabbing && x == xstart && y == ystart)
{
    with (other)
    {
        fmod_event_one_shot_3d("event:/sfx/pep/bumpwall", x, y);
        
        if (state != states.chainsaw && state != states.backbreaker)
        {
            tauntstoredmovespeed = movespeed;
            tauntstoredvsp = vsp;
            tauntstoredsprite = sprite_index;
            tauntstoredstate = state;
        }
        
        with (instance_create(x, y - 5, obj_parryeffect))
        {
            image_yscale = -1;
            sprite_index = spr_grabhangeffect;
            image_speed = 0.35;
        }
        
        state = states.bump;
        
        if (boxxed == false)
            sprite_index = spr_player_catched;
        else
            sprite_index = spr_boxxedpep_air;
        
        other.playerid = id;
        other.state = states.grabbing;
        
        if (tauntstoredstate != states.mach2 && tauntstoredstate != states.mach3)
        {
            tauntstoredstate = states.jump;
            tauntstoredsprite = spr_jump;
            tauntstoredmovespeed = 0;
            tauntstoredvsp = 0;
        }
        else if (tauntstoredstate == states.mach2)
            sprite_index = spr_mach;
        else if (tauntstoredstate == states.mach3)
            sprite_index = spr_mach4;
    }
}
