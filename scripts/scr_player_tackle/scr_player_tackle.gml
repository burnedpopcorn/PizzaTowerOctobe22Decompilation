function scr_player_tackle()
{
    combo = 0;
    mach2 = 0;
    hsp = -xscale * movespeed;
    start_running = true;
    jumpAnim = true;
    dashAnim = true;
    landAnim = false;
    moveAnim = true;
    stopAnim = true;
    crouchslideAnim = true;
    crouchAnim = true;
    
    if (sprite_index != spr_player_lungehit)
    {
        if (sprite_index != spr_golfswing)
        {
            if (grounded && vsp > 0.5)
                state = states.normal;
        }
        else if (ANIMATION_ENDED && grounded)
        {
            state = states.normal;
        }
    }
    else
    {
        movespeed = Approach(movespeed, 0, 0.1);
        
        if (ANIMATION_ENDED && grounded && vsp > 0)
            state = states.normal;
    }
    
    if (ANIMATION_PLAYING)
        image_speed = 0.35;
    else
        image_speed = 0;
}
