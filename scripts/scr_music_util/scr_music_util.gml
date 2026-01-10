function add_music(arg0, arg1, arg2, arg3, arg4 = noone)
{
    var b = 
    {
        continuous: arg3,
        on_room_start: noone,
        value: 0,
        immediate: false,
        event: noone,
        event_secret: noone
    };
    
    with (b)
    {
        if (arg4 != noone)
            on_room_start = method(self, arg4);
        
        if (arg1 != noone)
        {
            event_name = arg1;
            event = fmod_event_create_instance(arg1);
        }
        
        if (arg2 != noone)
        {
            event_secret_name = arg2;
            event_secret = fmod_event_create_instance(arg2);
        }
    }
    
    music_map[? arg0] = b;
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

function hub_state(arg0, arg1, arg2)
{
    var s = 0;
    
    switch (arg0)
    {
        case 248:
        case 214:
            s = 0;
            break;
        
        case 292:
        case 192:
            s = 0;
            break;
        
        case 267:
        case 360:
            s = 2;
            break;
        
        case 335:
        case 281:
            s = 3;
            break;
        
        case 339:
            s = 0;
            break;
    }
    
    fmod_event_instance_set_parameter(arg1, "hub", s, false);
}

function music_get_pos_wrap(arg0, arg1)
{
    while (arg0 > arg1)
        arg0 -= arg1;
    
    if (arg0 < 1)
        arg0 = 1;
    
    return arg0;
}
