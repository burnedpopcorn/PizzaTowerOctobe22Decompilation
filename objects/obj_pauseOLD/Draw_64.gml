if (instance_exists(obj_keyconfig))
    exit;

if (pause)
{
    var pad = 48;
    draw_set_alpha(1);
    draw_rectangle_color(0, 0, obj_screensizer.actual_width, obj_screensizer.actual_height, c_black, c_black, c_black, c_black, false);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    var xx = (obj_screensizer.actual_width / 2) + 10;
    var yy = 48;
    
    for (var i = 0; i < array_length(pause_menu); i++)
    {
        var c = 8421504;
        yy = 96 + (pad * i);
        
        if (selected == i)
        {
            c = 16777215;
            draw_sprite(spr_cursor, cursor_index, xx - 48, yy + (cursor_sprite_height / 2));
        }
        
        draw_text_color(xx, yy, lang_get_value(pause_menu[i]), c, c, c, c, 1);
    }
    
    xx = (obj_screensizer.actual_width / 2) - 224;
    yy = 192;
    shader_set(global.Pal_Shader);
    pal_swap_set(spr_palette, paletteselect, false);
    draw_sprite(peppino_sprite, peppino_index, xx, yy);
    reset_shader_fix();
    draw_set_font(global.collectfont);
    draw_set_halign(fa_center);
    xx = (obj_screensizer.actual_width / 2) + 209;
    yy = (obj_screensizer.actual_height / 2) + 146;
    draw_sprite(spr_pizzascore, 0, xx, yy);
    
    if (global.collect >= global.crank)
        draw_sprite(spr_pizzascore_pepper, 0, xx, yy);
    
    if (global.collect >= global.brank)
        draw_sprite(spr_pizzascore_pepperoni, 0, xx, yy);
    
    if (global.collect >= global.arank)
        draw_sprite(spr_pizzascore_olive, 0, xx, yy);
    
    if (global.collect >= global.srank)
        draw_sprite(spr_pizzascore_shroom, 0, xx, yy);
    
    draw_text(xx, yy - 54, global.collect);
    var rank = "D";
    
    if (global.collect >= global.crank)
        rank = "C";
    
    if (global.collect >= global.brank)
        rank = "B";
    
    if (global.collect >= global.arank)
        rank = "A";
    
    if (global.collect >= global.srank)
        rank = "S";
    
    xx = (obj_screensizer.actual_width / 2) - 308;
    yy = (obj_screensizer.actual_height / 2) + 134;
    pad = 40;
    
    for (var i = 0; i < array_length(toppin_sprite); i++)
        draw_sprite_ext(toppin_sprite[i], toppin_index[i], xx + (pad * i), yy, 1, 1, 0, c_white, toppin_has[i] ? 1 : 0.5);
}
