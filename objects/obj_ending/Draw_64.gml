draw_set_font(global.creditsfont);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_alpha(1);
draw_set_color(c_white);
var yy = credits_y;

for (var i = 0; i < array_length(credits_str); i++)
{
    var b = credits_str[i];
    draw_text(obj_screensizer.actual_width / 2, yy, b);
    yy += string_height(b);
}

draw_set_valign(fa_top);
draw_set_halign(fa_left);
