function scr_player_mortattack()
{
    image_speed = 0.45;
    hsp = movespeed;
    
    if (ANIMATION_ENDED)
    {
        if (grounded && vsp > 0)
        {
            state = states.mort;
            sprite_index = spr_player_mortidle;
            landAnim = false;
        }
        else
        {
            state = states.mortjump;
            sprite_index = spr_player_mortjump;
        }
    }
    
    if (punch_afterimage > 0)
    {
        punch_afterimage--;
    }
    else
    {
        punch_afterimage = 5;
        create_blue_afterimage(x, y, sprite_index, image_index, xscale);
    }
}
