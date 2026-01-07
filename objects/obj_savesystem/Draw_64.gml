if (showicon)
{
    var a = clamp(icon_alpha, 0, 1);
    draw_sprite_ext(spr_pizzaslice, icon_index, obj_screensizer.actual_width - 64, obj_screensizer.actual_height - 60, 1, 1, 0, c_white, a);
}
