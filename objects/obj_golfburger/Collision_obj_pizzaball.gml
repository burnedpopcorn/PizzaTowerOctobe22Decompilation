if (state != states.throwing && state != states.stun && state != states.grabbed && other.state != states.golf)
{
    golfid = other.id;
    shot = false;
    state = states.throwing;
    sprite_index = spr_golfburger_golf;
    image_index = 0;
    
    if (shootdir == 0)
        image_xscale = choose(-1, 1);
    else
        image_xscale = shootdir;
}
