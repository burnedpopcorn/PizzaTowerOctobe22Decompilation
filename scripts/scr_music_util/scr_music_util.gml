function add_music(_room, _event, _secretevent, _continuous, _func = noone)
{
    var b = 
    {
        continuous: _continuous,
        on_room_start: noone,
        value: 0,
        immediate: false,
        event: noone,
        event_secret: noone
    };
    
    with (b)
    {
        if (_func != noone)
            on_room_start = method(self, _func);
        
        if (_event != noone)
        {
            event_name = _event;
            event = fmod_event_create_instance(_event);
        }
        
        if (_secretevent != noone)
        {
            event_secret_name = _secretevent;
            event_secret = fmod_event_create_instance(_secretevent);
        }
    }
    
    music_map[? _room] = b;
    return b;
}

function stop_music()
{
    with (obj_music)
    {
        if (music != noone)
        {
            fmod_event_instance_stop(music.event, true);
            fmod_event_instance_stop(music.event_secret, true);
        }
        
        fmod_event_instance_stop(pillarmusicID, true);
        fmod_event_instance_stop(panicmusicID, true);
    }
}

function hub_state(_room, _sound, _unused)
{
    var s = 0;
    
    switch (_room)
    {
        case tower_1:
        case tower_1up:
            s = 0;
            break;
        
        case tower_2:
        case tower_2up:
            s = 0;
            break;
        
        case tower_3:
        case tower_3up:
            s = 2;
            break;
        
        case tower_4:
        case tower_4up:
            s = 3;
            break;
        
        case tower_5:
            s = 0;
            break;
    }
    
    fmod_event_instance_set_parameter(_sound, "hub", s, false);
}

function music_get_pos_wrap(_pos, _length)
{
    while (_pos > _length)
        _pos -= _length;
    
    if (_pos < 1)
        _pos = 1;
    
    return _pos;
}
