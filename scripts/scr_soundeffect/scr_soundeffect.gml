function scr_soundeffect()
{
    var snd = argument[irandom(argument_count - 1)];
    var snd_id = audio_play_sound(snd, 1, false);
    audio_sound_gain(snd_id, audio_sound_get_gain(snd_id) * global.option_sfx_volume, 0);
    return snd_id;
}

function sfx_gain(arg0)
{
    audio_sound_gain(arg0, audio_sound_get_gain(arg0) * global.option_sfx_volume, 0);
}

function set_audio_config()
{
    ini_open("saveData.ini");
    ini_write_real("Option", "master_volume", global.option_master_volume);
    ini_write_real("Option", "music_volume", global.option_music_volume);
    ini_write_real("Option", "sfx_volume", global.option_sfx_volume);
    ini_close();
    fmod_set_parameter("masterVolume", global.option_master_volume, true);
    fmod_set_parameter("musicVolume", global.option_music_volume, true);
    fmod_set_parameter("sfxVolume", global.option_sfx_volume, true);
}
