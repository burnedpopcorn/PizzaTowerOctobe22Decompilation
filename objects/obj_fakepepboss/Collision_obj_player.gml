if ((other.state == states.handstandjump || other.instakillmove) && visible && (state == states.walk || (state == states.jump && sprite_index == spr_fakepeppino_bodyslamstart) || (state == states.freefall && sprite_index == spr_fakepeppino_bodyslamland) || (state == states.mach2 && attackspeed < 18) || state == states.Sjumpprep || (state == states.throwing && sprite_index != spr_fakepeppino_flailing)))
{
    if (subhp > 0)
    {
        if (state == states.walk)
        {
            state = states.staggered;
            image_xscale = -other.xscale;
            hsp = -image_xscale * 8;
            vsp = 0;
            sprite_index = spr_fakepeppino_stagger;
            image_index = 0;
        }
        else
        {
            flashbuffer = 9;
        }
        
        flash = true;
        subhp--;
        
        repeat (4)
            create_debris(x, y, spr_slapstar);
    }
    else
    {
        state = states.stun;
        image_xscale = -other.xscale;
        hsp = -image_xscale * 8;
        vsp = -6;
        thrown = false;
        linethrown = false;
        sprite_index = spr_fakepeppino_vulnerable;
        stunned = 200;
        flash = true;
        
        repeat (4)
            create_debris(x, y, spr_slapstar);
    }
    
    with (other)
    {
        fmod_event_one_shot_3d("event:/sfx/enemies/killingblow", x, y);
        state = states.tackle;
        movespeed = 4;
        sprite_index = spr_player_lungehit;
        image_index = 0;
    }
}
else if (state == states.freefall || (state == states.mach2 && attackspeed >= 18) || state == states.Sjump || (state == states.throwing && attackspeed > 0))
{
    if (other.flash)
        flash = false;
    
    scr_hurtplayer(other);
}
