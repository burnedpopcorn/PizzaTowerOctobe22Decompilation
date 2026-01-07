if (state != states.johnghost)
{
    with (other)
    {
        hitX = x;
        hitY = y;
        state = states.johnghost;
        sprite_index = spr_hurt;
        image_speed = 0.35;
    }
    
    fmod_event_one_shot("event:/sfx/pep/johnghost");
    fadein = false;
    state = states.johnghost;
    playerid = other.id;
}
