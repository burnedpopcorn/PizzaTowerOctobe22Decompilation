function scr_fmod_soundeffect(arg0, arg1, arg2)
{
    fmod_event_instance_set_3d_attributes(arg0, arg1, arg2);
    fmod_event_instance_play(arg0);
}
