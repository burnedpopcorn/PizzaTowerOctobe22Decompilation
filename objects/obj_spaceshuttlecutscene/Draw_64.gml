if (start)
{
    var w = sprite_get_width(bg_space1);
    var h = sprite_get_height(bg_space1);
    var bgx = bg_x;
    var bgy = bg_y - 200;
    draw_sprite(bg_space1, 0, bgx, bgy);
    draw_sprite(bg_space1, 0, bgx - w, bgy);
    draw_sprite(bg_space1, 0, bgx + w, bgy);
    draw_sprite(bg_space1, 0, bgx, bgy - h);
    draw_sprite(bg_space1, 0, bgx, bgy + h);
    draw_sprite(bg_space1, 0, bgx - w, bgy - h);
    draw_sprite(bg_space1, 0, bgx + w, bgy - h);
    draw_sprite(bg_space1, 0, bgx + w, bgy + h);
    draw_sprite(bg_space1, 0, bgx - w, bgy + h);
    draw_sprite(sprite_index, image_index, irandom_range(-shake_mag, shake_mag), irandom_range(-shake_mag, shake_mag));
}

draw_set_alpha(fade);
draw_rectangle_color(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);

if (instance_exists(obj_fadeout))
{
    draw_set_alpha(obj_fadeout.fadealpha);
    draw_rectangle_color(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
}
