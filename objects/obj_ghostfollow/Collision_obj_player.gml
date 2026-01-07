if (state != UnknownEnum.Value_291)
{
    with (other)
    {
        hitX = x;
        hitY = y;
        state = UnknownEnum.Value_291;
        sprite_index = spr_hurt;
        image_speed = 0.35;
    }
    
    fmod_event_one_shot("event:/sfx/pep/johnghost");
    fadein = false;
    state = UnknownEnum.Value_291;
    playerid = other.id;
}
