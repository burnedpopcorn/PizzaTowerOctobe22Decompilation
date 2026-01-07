if (start)
{
    draw_sprite(bgsprite, bgindex, 0, 0);
    draw_sprite(sprite_index, image_index, 0, irandom_range(-shake_mag, shake_mag));
}

draw_set_alpha(fade);
draw_rectangle_color(0, 0, obj_screensizer.actual_width, obj_screensizer.actual_height, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);
