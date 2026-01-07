function screen_apply_size()
{
    with (obj_screensizer)
    {
        window_set_size(get_resolution_width(global.option_resolution, aspect_ratio), get_resolution_height(global.option_resolution, aspect_ratio));
        alarm[0] = 2;
    }
}

function surface_safe_set_target(arg0)
{
    surface_reset_target();
    surface_set_target(arg0);
}

function set_gui_target(arg0)
{
    while (surface_get_target() != -1 && surface_get_target() != application_surface)
        surface_reset_target();
    
    surface_set_target(arg0);
}

function surface_safe_reset_target()
{
    if (surface_get_target() != -1 && surface_get_target() != application_surface)
        surface_reset_target();
}

function reset_gui_target()
{
    while (surface_get_target() != -1 && surface_get_target() != application_surface)
        surface_reset_target();
    
    with (obj_screensizer)
    {
        if (!surface_exists(gui_surf))
            exit;
        
        surface_set_target(gui_surf);
    }
}

function reset_blendmode()
{
    gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
}

function reset_shader_fix()
{
    if (shader_current() != -1)
        shader_reset();
    
    shader_set(shd_alphafix);
}

function window_to_gui_x(arg0)
{
    var _win_pos = arg0 / window_get_width();
    return display_get_gui_width() * _win_pos;
}

function window_to_gui_y(arg0)
{
    var _win_pos = arg0 / window_get_height();
    return display_get_gui_height() * _win_pos;
}

function window_to_gui_xscale(arg0)
{
    return (arg0 * display_get_gui_width()) / window_get_width();
}

function window_to_gui_yscale(arg0)
{
    return (arg0 * display_get_gui_height()) / window_get_height();
}

function get_resolution_width(arg0, arg1 = UnknownEnum.Value_0)
{
    if (arg0 < 0 || arg0 >= array_length(global.resolutions[arg1]))
        return get_resolution_width(1, arg1);
    
    return global.resolutions[arg1][arg0][0];
}

function get_resolution_height(arg0, arg1 = UnknownEnum.Value_0)
{
    if (arg0 < 0 || arg0 >= array_length(global.resolutions[arg1]))
        return get_resolution_height(1, arg1);
    
    return global.resolutions[arg1][arg0][1];
}

function get_resolution(arg0, arg1 = UnknownEnum.Value_0)
{
    if (arg0 < 0 || arg0 >= array_length(global.resolutions[arg1]))
        return noone;
    
    return global.resolutions[arg1][arg0];
}

function screen_clear(arg0 = 0)
{
    draw_rectangle_color(0, 0, obj_screensizer.actual_width, obj_screensizer.actual_height, arg0, arg0, arg0, arg0, false);
}

function get_options()
{
    ini_open("saveData.ini");
    global.option_fullscreen = ini_read_real("Option", "fullscreen", 1);
    global.option_resolution = ini_read_real("Option", "resolution", 1);
    global.option_master_volume = ini_read_real("Option", "master_volume", 1);
    global.option_music_volume = ini_read_real("Option", "music_volume", 1);
    global.option_sfx_volume = ini_read_real("Option", "sfx_volume", 1);
    global.option_vibration = ini_read_real("Option", "vibration", 1);
    global.option_scale_mode = ini_read_real("Option", "scale_mode", 0);
    global.option_hud = ini_read_real("Option", "hud", 1);
    global.option_lang = ini_read_string("Option", "lang", "en");
    global.option_timer = ini_read_real("Option", "timer", 0);
    global.option_timer_type = ini_read_real("Option", "timer_type", 0);
    global.lang = global.option_lang;
    ini_close();
    
    if (global.option_fullscreen == 0)
        window_set_fullscreen(false);
    
    if (global.option_fullscreen == 1)
    {
        window_set_fullscreen(true);
        window_set_size(display_get_width(), display_get_height());
        obj_screensizer.window_width_current = 0;
        obj_screensizer.window_height_current = 0;
    }
    
    obj_screensizer.start_sound = false;
}
