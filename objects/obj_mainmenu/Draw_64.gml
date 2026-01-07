draw_set_font(lang_get_font("bigfont"));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

if (state == states.titlescreen)
    draw_text(obj_screensizer.actual_width / 2, (obj_screensizer.actual_height / 2) - 100, "PRESS START");
else
    draw_text(obj_screensizer.actual_width / 2, obj_screensizer.actual_height - 40, concat("FILE ", currentselect + 1));
