if (app_scale <= 0)
    exit;

draw_set_alpha(1);
gpu_set_blendmode(bm_normal);
draw_set_color(c_white);
draw_rectangle_color(0, 0, window_get_width(), window_get_height(), c_black, c_black, c_black, c_black, false);
gpu_set_blendenable(false);
draw_surface(application_surface, (window_get_width() / 2) - (surface_get_width(application_surface) / 2), (window_get_height() / 2) - (surface_get_height(application_surface) / 2));
gpu_set_blendenable(true);
