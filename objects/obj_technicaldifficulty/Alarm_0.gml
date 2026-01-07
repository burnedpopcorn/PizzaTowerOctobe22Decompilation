use_static = true;
static_index = sprite_get_number(spr_tvstatic) - 1;
static_dir = -1;

with (playerid)
{
    if (!isgustavo)
        state = states.normal;
    else
        state = states.ratmount;
    
    visible = true;
}

with (obj_ghostfollow)
{
    x = xstart;
    y = ystart;
}
