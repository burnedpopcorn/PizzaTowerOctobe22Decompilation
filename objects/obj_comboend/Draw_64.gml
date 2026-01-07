if (!global.option_hud || (instance_exists(obj_debugcontroller) && !obj_debugcontroller.showhud))
    exit;

var xx = x;
var yy = y;
draw_sprite(spr_comboend, 0, xx, yy);
var title = floor(combo / 5);
title = clamp(title, 0, floor((sprite_get_number(spr_comboend_title1) - 1) / 2));
draw_sprite(spr_comboend_title1, (title * 2) + title_index, xx, yy + 30);
draw_set_font(lang_get_font("smallfont"));
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(xx, yy + 60, comboscore);
