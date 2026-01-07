if ((other.state == states.handstandjump || other.instakillmove) && (state == states.walk || (state == states.jump && sprite_index == spr_fakepeppino_bodyslamstart) || (state == states.freefall && sprite_index == spr_fakepeppino_bodyslamland) || (state == states.mach2 && attackspeed < 18) || (state == states.throwing && sprite_index != spr_fakepeppino_flailing)))
{
    state = states.transitioncutscene;
    sprite_index = spr_fakepeppino_deform;
    image_index = 0;
    flash = true;
    alarm[2] = 9;
    
    repeat (4)
        create_debris(x, y, spr_slapstar);
    
    with (other)
    {
        fmod_event_one_shot_3d("event:/sfx/enemies/killingblow", x, y);
        state = states.tackle;
        movespeed = 3;
        sprite_index = spr_player_lungehit;
        image_index = 0;
    }
}
else if (state == states.freefall || (state == states.mach2 && attackspeed >= 50) || state == states.Sjump || (state == states.throwing && sprite_index == spr_fakepeppino_flailing))
{
    if (other.flash)
        flash = false;
    
    scr_hurtplayer(other);
}
