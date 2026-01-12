prevpillar_on_camera = pillar_on_camera;

if (instance_exists(obj_hungrypillar))
{
    var p = false;
    
    with (obj_hungrypillar)
    {
        if (bbox_in_camera(view_camera[0], 0))
            p = true;
    }
    
    if (p != pillar_on_camera)
        pillar_on_camera = p;
}
else
    pillar_on_camera = false;

if (prevpillar_on_camera != pillar_on_camera)
{
    if (pillar_on_camera)
        fmod_set_parameter("pillarfade", 1, false);
    else
        fmod_set_parameter("pillarfade", 0, false);
}

if (global.panic)
{
    if (!panicstart)
    {
        panicstart = true;
        
        if (room != tower_finalhallway)
        {
            fmod_event_instance_play(panicmusicID);
            fmod_event_instance_set_parameter(panicmusicID, "state", 0, true);
        }
        
        if (music != noone)
        {
            fmod_event_instance_stop(music.event, true);
            fmod_event_instance_stop(music.event_secret, true);
        }
        
        if (room == tower_finalhallway)
        {
            fmod_event_instance_stop(panicmusicID);
            fmod_event_instance_play(music.event);
        }
        
        fmod_event_instance_stop(pillarmusicID, true);
        fmod_set_parameter("pillarfade", 0, true);
        fmod_event_instance_set_parameter(panicmusicID, "state", 0, true);
    }
    else if (fmod_event_instance_is_playing(panicmusicID))
    {
        if (global.fill <= 720)
            fmod_event_instance_set_parameter(panicmusicID, "state", 2, true);
    }
}
else
{
    panicstart = false;
    fmod_event_instance_stop(panicmusicID, true);
}
