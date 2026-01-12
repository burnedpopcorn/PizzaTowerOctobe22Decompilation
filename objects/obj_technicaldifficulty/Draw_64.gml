if (use_static)
    draw_sprite(spr_tvstatic, static_index, 0, 0);
else
{
    screen_clear(make_color_rgb(216, 104, 160));
    draw_sprite(spr_technicaldifficulty_bg, 0, obj_screensizer.normal_size_fix_x, obj_screensizer.normal_size_fix_y);
    draw_sprite(sprite, 0, obj_screensizer.normal_size_fix_x + 300, obj_screensizer.normal_size_fix_y + 352);
}
