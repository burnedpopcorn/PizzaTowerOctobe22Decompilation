function scr_player_arenaintro()
{
    hsp = 0;
    hurted = false;
    inv_frames = false;
    
    if (sprite_index == spr_player_bossintro && ANIMATION_ENDED)
        image_index = 3;
    
    if (sprite_index == spr_player_levelcomplete && ANIMATION_ENDED)
        image_speed = 0;
    else
        image_speed = 0.35;
}
