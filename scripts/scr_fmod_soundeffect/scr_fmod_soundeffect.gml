function scr_fmod_soundeffect(_inst, _x, _y)
{
    fmod_event_instance_set_3d_attributes(_inst, _x, _y);
    fmod_event_instance_play(_inst);
}
