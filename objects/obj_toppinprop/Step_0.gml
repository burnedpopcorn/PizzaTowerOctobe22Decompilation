mask_index = spr_player_mask;

switch (state)
{
    case states.normal:
        sprite_index = movespr;
        hsp = image_xscale * 2;
        
        if (scr_solid(x + sign(hsp), y))
        {
            image_xscale *= -1;
            hsp *= -1;
        }
        else if (!(scr_solid(x + (image_xscale * 32), y + 31) || place_meeting(x + (image_xscale * 32), y + 31, obj_platform)))
        {
            image_xscale *= -1;
            hsp *= -1;
        }
        
        x += hsp;
        break;
    
    case states.idle:
        sprite_index = idlespr;
        hsp = 0;
        break;
}

vsp = 0;
