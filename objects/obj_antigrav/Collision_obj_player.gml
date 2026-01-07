with (other)
{
    if (state != states.antigrav && state != states.backbreaker && state != states.chainsaw)
    {
        create_transformation_tip(lang_get_value("antigravtip"), "antigrav");
        state = states.antigrav;
        vsp = 0;
        fmod_event_one_shot("event:/sfx/antigrav/start");
        
        with (obj_antigravbubble)
        {
            if (playerid == other.id)
                instance_destroy();
        }
        
        with (instance_create(x, y, obj_antigravbubble))
            playerid = other.id;
        
        other.image_index = 0;
        other.sprite_index = spr_antigrav_activate;
    }
}
