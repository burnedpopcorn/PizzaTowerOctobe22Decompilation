function scr_sound()
{
    var snd = argument[irandom(argument_count - 1)];
    global.music = audio_play_sound(snd, 10, true);
    audio_sound_gain(global.music, 0.6 * global.option_music_volume, 0);
}

function scr_music(arg0, arg1 = true, arg2 = 0.8)
{
    var m = audio_play_sound(arg0, 10, arg1);
    audio_sound_gain(m, audio_sound_get_gain(arg0) * arg2 * global.option_music_volume, 0);
    return m;
}

function set_master_gain(arg0)
{
    var num = audio_get_listener_count();
    
    for (var i = 0; i < num; i++)
    {
        var info = audio_get_listener_info(i);
        audio_set_master_gain(ds_map_find_value(info, "index"), arg0);
        ds_map_destroy(info);
    }
}
