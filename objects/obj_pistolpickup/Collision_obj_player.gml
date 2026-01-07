if (other.state == states.handstandjump)
{
    with (other)
    {
        state = states.animation;
        sprite_index = spr_player_pistolintro;
        image_index = 0;
        image_speed = 0.35;
        tauntstoredstate = states.normal;
    }
    
    global.pistol = true;
    instance_destroy();
}
