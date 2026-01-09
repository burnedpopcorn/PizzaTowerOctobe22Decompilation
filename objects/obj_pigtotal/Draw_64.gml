draw_sprite(spr_pigtotal, -1, SCREEN_WIDTH - 100, SCREEN_HEIGHT - 100);
draw_set_font(global.bigfont);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(SCREEN_WIDTH - 100, SCREEN_HEIGHT - 100, string(global.pigtotal - global.pigreduction));
