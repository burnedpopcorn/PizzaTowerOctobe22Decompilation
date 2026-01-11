#macro SCREEN_WIDTH obj_screensizer.actual_width
#macro SCREEN_HEIGHT obj_screensizer.actual_height
#macro CAMERA_WIDTH obj_screensizer.ideal_width
#macro CAMERA_HEIGHT obj_screensizer.ideal_height

function screen_apply_size()
{
    with (obj_screensizer)
    {
        window_set_size(get_resolution_width(global.option_resolution, aspect_ratio), get_resolution_height(global.option_resolution, aspect_ratio));
        alarm[0] = 2;
    }
}

function surface_safe_set_target(_surf)
{
    surface_reset_target();
    surface_set_target(_surf);
}

function set_gui_target(_surf)
{
    while (surface_get_target() != -1 && surface_get_target() != application_surface)
        surface_reset_target();
    
    surface_set_target(_surf);
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

function window_to_gui_x(_x)
{
    var _win_pos = _x / window_get_width();
    return display_get_gui_width() * _win_pos;
}

function window_to_gui_y(_y)
{
    var _win_pos = _y / window_get_height();
    return display_get_gui_height() * _win_pos;
}

function window_to_gui_xscale(_xscale)
{
    return (_xscale * display_get_gui_width()) / window_get_width();
}

function window_to_gui_yscale(_yscale)
{
    return (_yscale * display_get_gui_height()) / window_get_height();
}

function get_resolution_width(_resolution, _aspect_ratio = aspectratio.normal)
{
    if (_resolution < 0 || _resolution >= array_length(global.resolutions[_aspect_ratio]))
        return get_resolution_width(1, _aspect_ratio);
    
    return global.resolutions[_aspect_ratio][_resolution][0];
}

function get_resolution_height(_resolution, _aspect_ratio = aspectratio.normal)
{
    if (_resolution < 0 || _resolution >= array_length(global.resolutions[_aspect_ratio]))
        return get_resolution_height(1, _aspect_ratio);
    
    return global.resolutions[_aspect_ratio][_resolution][1];
}

function get_resolution(_resolution, _aspect_ratio = aspectratio.normal)
{
    if (_resolution < 0 || _resolution >= array_length(global.resolutions[_aspect_ratio]))
        return noone;
    
    return global.resolutions[_aspect_ratio][_resolution];
}

function screen_clear(_color = c_black)
{
    draw_rectangle_color(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, _color, _color, _color, _color, false);
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
