if (window_width_current != window_get_width() || window_height_current != window_get_height() || global.option_scale_mode != last_scale_mode || global.option_fullscreen != window_get_fullscreen())
{
    var ww = window_get_width();
    var wh = window_get_height();
    
    if (window_get_fullscreen())
    {
        ww = display_get_width();
        wh = display_get_height();
    }
    
    if (global.option_scale_mode == 0)
    {
        camera_set_view_size(view_camera[0], CAMERA_WIDTH, CAMERA_HEIGHT);
        app_scale = min(ww / CAMERA_WIDTH, wh / CAMERA_HEIGHT);
        trace(app_scale);
        SCREEN_WIDTH = CAMERA_WIDTH;
        SCREEN_HEIGHT = CAMERA_HEIGHT;
        
        if (app_scale > 0)
        {
            surface_resize(application_surface, CAMERA_WIDTH * app_scale, CAMERA_HEIGHT * app_scale);
            display_set_gui_size(CAMERA_WIDTH, CAMERA_HEIGHT);
        }
    }
    else if (global.option_scale_mode == 1)
    {
        camera_set_view_size(view_camera[0], CAMERA_WIDTH, CAMERA_HEIGHT);
        app_scale = min(ww div CAMERA_WIDTH, wh div CAMERA_HEIGHT);
        SCREEN_WIDTH = CAMERA_WIDTH;
        SCREEN_HEIGHT = CAMERA_HEIGHT;
        
        if (app_scale > 0)
        {
            surface_resize(application_surface, CAMERA_WIDTH * app_scale, CAMERA_HEIGHT * app_scale);
            display_set_gui_size(CAMERA_WIDTH, CAMERA_HEIGHT);
        }
    }
    else if (global.option_scale_mode == 2)
    {
        app_scale = 1;
        camera_set_view_size(view_camera[0], ww, wh);
        SCREEN_WIDTH = ww;
        SCREEN_HEIGHT = wh;
        
        if (ww > 0 && wh > 0)
        {
            surface_resize(application_surface, SCREEN_WIDTH, SCREEN_HEIGHT);
            display_set_gui_size(SCREEN_WIDTH, SCREEN_HEIGHT);
        }
    }
    
    last_scale_mode = global.option_scale_mode;
    last_fullscreen = window_get_fullscreen();
    window_width_current = window_get_width();
    window_height_current = window_get_height();
    normal_size_fix_x = (SCREEN_WIDTH - 960) / 2;
    normal_size_fix_y = (SCREEN_HEIGHT - 540) / 2;
}
