var cx = camera_get_view_x(view_camera[0]);
var cy = camera_get_view_y(view_camera[0]);
draw_sprite_ext(sprite1122, 0, cx, cy, SCREEN_WIDTH / 64, SCREEN_HEIGHT / 64, 0, c_white, 1);
draw_sprite(spr_mainmenu_bg, 0, cx + obj_screensizer.normal_size_fix_x, cy);
draw_sprite(spr_controlseggplant, 0, cx + (SCREEN_WIDTH * 0.853125), cy + 84);
draw_sprite_ext(sprite_index, image_index, cx + (SCREEN_WIDTH * 0.50625), cy + y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
