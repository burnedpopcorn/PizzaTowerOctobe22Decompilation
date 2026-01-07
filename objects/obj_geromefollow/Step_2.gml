yoffset = 0;

if (sprite_index != spr_gerome_collected)
{
    event_inherited();
    
    if (!do_end)
        visible = obj_player1.visible;
    
    sprite_index = (x != xprevious) ? spr_gerome_keymove : spr_gerome_keyidle;
    
    if ((xprevious - x) != 0)
        image_xscale = -sign(xprevious - x);
    else if (playerid.hsp == 0)
        image_xscale = playerid.xscale;
}
