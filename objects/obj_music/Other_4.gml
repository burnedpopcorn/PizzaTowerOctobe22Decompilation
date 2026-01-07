if (!global.panic)
{
    var mu = ds_map_find_value(music_map, room);
    
    if (!is_undefined(mu))
    {
        var prevmusic = music;
        
        if (prevmusic == -4 || mu.event_name != prevmusic.event_name)
        {
            fmod_event_instance_play(mu.event);
            
            if (mu.continuous && prevmusic != -4)
            {
                var pos = fmod_event_instance_get_timeline_pos(prevmusic.event);
                pos = music_get_pos_wrap(pos, fmod_event_get_length(mu.event_name));
                fmod_event_instance_set_timeline_pos(mu.event, pos);
            }
            
            if (prevmusic != -4)
            {
                fmod_event_instance_stop(prevmusic.event, true);
                
                if (prevmusic.event_secret != -4)
                    fmod_event_instance_stop(prevmusic.event_secret, true);
            }
            
            music = mu;
            
            if (room == war_1 || room == tower_finalhallway || room == tower_pizzafacehall)
                fmod_event_instance_stop(music.event, true);
        }
    }
    
    if (instance_exists(obj_hungrypillar))
    {
        fmod_event_instance_play(pillarmusicID);
        fmod_set_parameter("pillarfade", 0, true);
    }
    else
    {
        fmod_event_instance_stop(pillarmusicID, true);
    }
}

if (music != -4 && music.on_room_start != -4)
    music.on_room_start(room, music.event, music.event_secret);

if (secret)
{
    if (music != -4 && music.event_secret != -4)
    {
        fmod_event_instance_play(music.event_secret);
        var pos = fmod_event_instance_get_timeline_pos(music.event);
        pos = music_get_pos_wrap(pos, fmod_event_get_length(music.event_secret_name));
        fmod_event_instance_set_timeline_pos(music.event_secret, pos);
        fmod_event_instance_set_paused(music.event, true);
        
        if (global.panic)
            fmod_event_instance_set_paused(panicmusicID, true);
    }
}
else if (secretend)
{
    secretend = false;
    
    if (music != -4)
    {
        fmod_event_instance_stop(music.event_secret, true);
        fmod_event_instance_set_paused(music.event, false);
        
        if (global.panic)
            fmod_event_instance_set_paused(panicmusicID, false);
    }
}

if (room == rank_room)
{
    if (music != -4)
    {
        fmod_event_instance_stop(music.event, true);
        fmod_event_instance_stop(music.event_secret, true);
    }
}
