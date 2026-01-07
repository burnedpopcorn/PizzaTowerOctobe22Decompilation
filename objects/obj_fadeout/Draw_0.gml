draw_set_alpha(fadealpha);
draw_set_color(c_black);
draw_rectangle(camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]), camera_get_view_x(view_camera[0]) + obj_screensizer.actual_width, camera_get_view_y(view_camera[0]) + obj_screensizer.actual_height, false);
draw_set_alpha(1);
