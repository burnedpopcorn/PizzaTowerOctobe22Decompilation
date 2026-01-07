depth = -99;
stickpressed = false;
slidecount = 0;
slidebuffer = 0;
menus = [];
lastmenu = 0;
menu = 0;
optionselected = 0;
var categories = create_menu_fixed(menuids.categories, menuanchors.center, 0, 48);
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
var audio_menu = create_menu_fixed(menuids.audio, menuanchors.left, 150, 40);
add_option_press(audio_menu, 0, "option_back", function()
{
    menu_goto(menuids.categories);
});
add_option_slide(audio_menu, 1, "option_master", function(arg0)
{
    global.option_master_volume = arg0 / 100;
    set_audio_config();
}).value = global.option_master_volume * 100;
add_option_slide(audio_menu, 2, "option_music", function(arg0)
{
    global.option_music_volume = arg0 / 100;
    set_audio_config();
}).value = global.option_music_volume * 100;
add_option_slide(audio_menu, 3, "option_sfx", function(arg0)
{
    global.option_sfx_volume = arg0 / 100;
    set_audio_config();
}).value = global.option_sfx_volume * 100;
array_push(menus, audio_menu);
var video_menu = create_menu_fixed(menuids.video, menuanchors.left, 150, 40);
add_option_press(video_menu, 0, "option_back", function()
{
    menu_goto(menuids.categories);
});
add_option_toggle(video_menu, 1, "option_fullscreen", function(arg0)
{
    window_set_fullscreen(arg0);
    
    if (arg0)
    {
        window_set_size(display_get_width(), display_get_height());
        obj_screensizer.window_width_current = 0;
        obj_screensizer.window_height_current = 0;
    }
    else
    {
        screen_apply_size();
    }
    
    ini_open("saveData.ini");
    global.option_fullscreen = arg0;
    ini_write_real("Option", "fullscreen", arg0);
    ini_close();
}).value = global.option_fullscreen;
var res = [];

for (var i = 0; i < array_length(global.resolutions[obj_screensizer.aspect_ratio]); i++)
{
    var b = global.resolutions[obj_screensizer.aspect_ratio][i];
    array_push(res, create_option_value(concat(b[0], "X", b[1]), i, false));
}

add_option_multiple(video_menu, 2, "option_resolution", res, function(arg0)
{
    ini_open("saveData.ini");
    ini_write_real("Option", "resolution", arg0);
    ini_close();
    global.option_resolution = arg0;
    screen_apply_size();
}).value = global.option_resolution;
add_option_multiple(video_menu, 3, "option_scaling", [create_option_value("option_scaling_fit", 0), create_option_value("option_scaling_pp", 1)], function(arg0)
{
    ini_open("saveData.ini");
    ini_write_real("Option", "scale_mode", arg0);
    ini_close();
    global.option_scale_mode = arg0;
}).value = global.option_scale_mode;
add_option_toggle(video_menu, 4, "option_hud", function(arg0)
{
    ini_open("saveData.ini");
    ini_write_real("Option", "hud", arg0);
    ini_close();
    global.option_hud = arg0;
}).value = global.option_hud;
array_push(menus, video_menu);
var game_menu = create_menu_fixed(menuids.window, menuanchors.left, 150, 40);
add_option_press(game_menu, 0, "option_back", function()
{
    menu_goto(menuids.categories);
});
var lang = [];
var key = ds_map_find_first(global.lang_map);

for (var i = 0; i < ds_map_size(global.lang_map); i++)
{
    var l = ds_map_find_value(global.lang_map, key);
    array_push(lang, create_option_value(ds_map_find_value(l, "display_name"), key, false));
    key = ds_map_find_next(global.lang_map, key);
}

var lang_option = add_option_multiple(game_menu, 1, "option_lang", lang, function(arg0)
{
    ini_open("saveData.ini");
    ini_write_string("Option", "lang", arg0);
    ini_close();
    global.option_lang = arg0;
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
add_option_toggle(game_menu, 2, "option_timer", function(arg0)
{
    ini_open("saveData.ini");
    ini_write_real("Option", "timer", arg0);
    ini_close();
    global.option_timer = arg0;
}).value = global.option_timer;
add_option_multiple(game_menu, 3, "option_timer_type", [create_option_value("option_timer_level", 0), create_option_value("option_timer_save", 1)], function(arg0)
{
    ini_open("saveData.ini");
    ini_write_real("Option", "timer_type", arg0);
    ini_close();
    global.option_timer_type = arg0;
}).value = global.option_timer_type;
array_push(menus, game_menu);
