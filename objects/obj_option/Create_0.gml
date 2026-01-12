depth = -99;
stickpressed = false;
slidecount = 0;
slidebuffer = 0;
menus = [];
lastmenu = 0;
menu = 0;
optionselected = 0;

enum menuids 
{
	options = 0,
	audio = 1,
	video = 2,
	window = 3,
}

enum menuanchors 
{
	center = 0,
	left = 1,
}

#region Main Categories
var categories = create_menu_fixed(menuids.options, menuanchors.center, 0, 48);

add_option_press(categories, 0, "option_audio", function()
{
    menu_goto(menuids.audio);
});

add_option_press(categories, 1, "option_video", function()
{
    menu_goto(menuids.video);
});

add_option_press(categories, 2, "option_game", function()
{
    menu_goto(menuids.window);
});

add_option_press(categories, 3, "option_controls", function()
{
    obj_option.key_jump = false;
    
    with (instance_create_unique(0, 0, obj_keyconfig))
        depth = -100;
});

array_push(menus, categories);
#endregion
#region Audio Menu
var audio_menu = create_menu_fixed(menuids.audio, menuanchors.left, 150, 40);

add_option_press(audio_menu, 0, "option_back", function()
{
    menu_goto(menuids.options);
});

#region Master
add_option_slide(audio_menu, 1, "option_master", function(_value)
{
    global.option_master_volume = _value / 100;
    set_audio_config();
}).value = global.option_master_volume * 100;
#endregion
#region Music
add_option_slide(audio_menu, 2, "option_music", function(_value)
{
    global.option_music_volume = _value / 100;
    set_audio_config();
}).value = global.option_music_volume * 100;
#endregion
#region SFX
add_option_slide(audio_menu, 3, "option_sfx", function(_value)
{
    global.option_sfx_volume = _value / 100;
    set_audio_config();
}).value = global.option_sfx_volume * 100;
#endregion

array_push(menus, audio_menu);
#endregion
#region Video Menu
var video_menu = create_menu_fixed(menuids.video, menuanchors.left, 150, 40);

add_option_press(video_menu, 0, "option_back", function()
{
    menu_goto(menuids.options);
});

#region Fullscreen
add_option_toggle(video_menu, 1, "option_fullscreen", function(_value)
{
    window_set_fullscreen(_value);
    
    if (_value)
    {
        window_set_size(display_get_width(), display_get_height());
        obj_screensizer.window_width_current = 0;
        obj_screensizer.window_height_current = 0;
    }
    else
        screen_apply_size();
    
    ini_open("saveData.ini");
    global.option_fullscreen = _value;
    ini_write_real("Option", "fullscreen", _value);
    ini_close();
}).value = global.option_fullscreen;
#endregion
#region Resolution
var res = [];
for (var i = 0; i < array_length(global.resolutions[obj_screensizer.aspect_ratio]); i++)
{
    var b = global.resolutions[obj_screensizer.aspect_ratio][i];
    array_push(res, create_option_value(concat(b[0], "X", b[1]), i, false));
}
add_option_multiple(video_menu, 2, "option_resolution", res, function(_value)
{
    ini_open("saveData.ini");
    ini_write_real("Option", "resolution", _value);
    ini_close();
    global.option_resolution = _value;
    screen_apply_size();
}).value = global.option_resolution;
#endregion
#region Scaling
add_option_multiple(video_menu, 3, "option_scaling", 
[
	create_option_value("option_scaling_fit", 0), 
	create_option_value("option_scaling_pp", 1)
], 
function(_value)
{
    ini_open("saveData.ini");
    ini_write_real("Option", "scale_mode", _value);
    ini_close();
    global.option_scale_mode = _value;
}).value = global.option_scale_mode;
#endregion
#region HUD
add_option_toggle(video_menu, 4, "option_hud", function(_value)
{
    ini_open("saveData.ini");
    ini_write_real("Option", "hud", _value);
    ini_close();
    global.option_hud = _value;
}).value = global.option_hud;
#endregion

array_push(menus, video_menu);
#endregion
#region Game Menu
var game_menu = create_menu_fixed(menuids.window, menuanchors.left, 150, 40);

add_option_press(game_menu, 0, "option_back", function()
{
    menu_goto(menuids.options);
});

#region Lang
var lang = [];
var key = ds_map_find_first(global.lang_map);
for (var i = 0; i < ds_map_size(global.lang_map); i++)
{
    var l = global.lang_map[? key];
    array_push(lang, create_option_value(l[? "display_name"], key, false));
    key = ds_map_find_next(global.lang_map, key);
}
var lang_option = add_option_multiple(game_menu, 1, "option_lang", lang, function(_value)
{
    ini_open("saveData.ini");
    ini_write_string("Option", "lang", _value);
    ini_close();
    global.option_lang = _value;
    global.lang = global.option_lang;
});
var r = 0;
for (var i = 0; i < array_length(lang); i++)
{
    if (lang[i].value == global.option_lang)
    {
        r = i;
        break;
    }
}
lang_option.value = r;
#endregion
#region Timer
add_option_toggle(game_menu, 2, "option_timer", function(_value)
{
    ini_open("saveData.ini");
    ini_write_real("Option", "timer", _value);
    ini_close();
    global.option_timer = _value;
}).value = global.option_timer;
#endregion
#region Timer Type
add_option_multiple(game_menu, 3, "option_timer_type", 
[
	create_option_value("option_timer_level", 0), 
	create_option_value("option_timer_save", 1)
], 
function(_value)
{
    ini_open("saveData.ini");
    ini_write_real("Option", "timer_type", _value);
    ini_close();
    global.option_timer_type = _value;
}).value = global.option_timer_type;
#endregion

array_push(menus, game_menu);
#endregion
