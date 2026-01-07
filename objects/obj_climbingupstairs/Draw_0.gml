var cx = camera_get_view_x(view_camera[0]);
var cy = camera_get_view_y(view_camera[0]);
draw_sprite(sprite_index, image_index, cx + obj_screensizer.normal_size_fix_x, cy + obj_screensizer.normal_size_fix_y);
var h = (64 + obj_screensizer.normal_size_fix_y) / 64;
draw_sprite_ext(sprite1122, 0, cx, cy, obj_screensizer.actual_width / 64, h, 0, c_white, 1);
draw_sprite_ext(sprite1122, 0, cx, (cy + obj_screensizer.actual_height) - (h * 64), obj_screensizer.actual_width / 64, h, 0, c_white, 1);
