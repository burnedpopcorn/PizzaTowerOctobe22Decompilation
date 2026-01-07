if (other.state != states.gotoplayer)
{
    if (audio_is_playing(sfx_collecttopping))
        audio_stop_sound(sfx_collecttopping);
    
    scr_fmod_soundeffect(global.snd_collect, x, y);
    
    with (other)
        pizzashield = true;
    
    instance_destroy();
}
