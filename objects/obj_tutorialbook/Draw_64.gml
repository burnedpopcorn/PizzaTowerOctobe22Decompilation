if (text_state == states.titlescreen && text_y <= -(text_sprite_height * text_yscale))
    exit;

draw_sprite(spr_tutorialbubble_rope, 0, 64 + text_wave_x, text_y + text_wave_y);
draw_sprite(spr_tutorialbubble_rope, 0, (SCREEN_WIDTH - 64) + text_wave_x, text_y + text_wave_y);
var xx = text_borderpad + text_wave_x;
var yy = text_y + text_wave_y;
draw_sprite_ext(spr_tutorialbubble, 0, xx, yy, text_xscale, text_yscale, 0, c_white, 1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(font);
draw_set_color(c_white);
scr_draw_text_arr(xx + text_contentpad, yy + text_contentpad, text_arr);
