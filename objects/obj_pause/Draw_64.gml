if (instance_exists(obj_keyconfig))
    exit;

if (fade > 0)
{
    draw_set_color(c_white);
    
    if (pause)
    {
        draw_set_alpha(1);
        draw_sprite_ext(screensprite, 0, 0, 0, obj_screensizer.actual_width / surface_get_width(application_surface), obj_screensizer.actual_height / surface_get_height(application_surface), 0, c_white, 1);
        draw_sprite(guisprite, 0, 0, 0);
    }
    
    draw_set_alpha(fade - 0.5);
    draw_rectangle_color(0, 0, obj_screensizer.actual_width, obj_screensizer.actual_height, c_white, c_white, c_white, c_white, false);
    draw_set_alpha(fade);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(lang_get_font("bigfont"));
    var h = string_height("A");
    var pad = 16;
    var len = array_length(pause_menu);
    var wh = (h * len) + (pad * (len - 1));
    var yy = (obj_screensizer.actual_height / 2) - (wh / 2);
    
    for (var i = 0; i < len; i++)
    {
        var b = pause_menu[i];
        var c = 8421504;
        var t = lang_get_value(b);
        
        if (selected == i)
        {
            var cx = (obj_screensizer.actual_width / 2) - (string_width(t) / 2) - 60;
            draw_sprite(spr_pizzaangel, cursor_index, cx + cursor_x, yy + cursor_y);
            c = 16777215;
        }
        
        draw_text_color(obj_screensizer.actual_width / 2, yy, t, c, c, c, c, fade);
        yy += (h + pad);
    }
}

draw_set_alpha(1);
draw_sprite_ext(spr_pause_border, 0, border1_x, border1_y, -1, 1, 0, c_white, 1);
draw_sprite_ext(spr_pause_border, 0, border2_x, border2_y, 1, 1, 0, c_white, 1);
draw_sprite_ext(spr_pause_vine, 0, obj_screensizer.actual_width / 2, vine_y, 1, 1, 0, c_white, 1);
pause_draw_priests();
