function scr_player_boxxedpepspin()
{
    image_speed = 0.5;
    hsp = xscale * movespeed;
    doublejump = true;
    
    if (place_meeting(x, y + 1, obj_railparent))
    {
        var _railinst = instance_place(x, y + 1, obj_railparent);
        railmovespeed = _railinst.movespeed;
        raildir = _railinst.dir;
    }
    
    move = key_left + key_right;
    hsp = movespeed + (railmovespeed * raildir);
    
    if (abs(movespeed) > 6)
        movespeed = Approach(movespeed, 6, 0.1);
    
    instance_destroy(instance_place(x + hsp, y, obj_destructibles));
    
    if (scr_solid(x + hsp, y) && !place_meeting(x + hsp, y, obj_ratblock) && !place_meeting(x + hsp, y, obj_destructibles) && (!place_meeting(x + hsp, y, obj_slope) || scr_solid_slope(x + hsp, y)))
    {
        instance_create(x + hsp, y, obj_bangeffect);
        movespeed = -(sign(hsp) * 6);
    }
    
    if (!key_slap || abs(movespeed) <= 4)
    {
        state = states.boxxedpepjump;
        sprite_index = spr_boxxedpepair;
    }
}
