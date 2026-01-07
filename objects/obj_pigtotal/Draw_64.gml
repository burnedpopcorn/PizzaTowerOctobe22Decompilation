draw_sprite(spr_pigtotal, -1, obj_screensizer.actual_width - 100, obj_screensizer.actual_height - 100);
draw_set_font(global.bigfont);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(obj_screensizer.actual_width - 100, obj_screensizer.actual_height - 100, string(global.pigtotal - global.pigreduction));
