if (!global.option_timer || room == Realtitlescreen || room == Mainmenu || !global.option_hud)
    exit;

if (!global.option_hud || (instance_exists(obj_debugcontroller) && !obj_debugcontroller.showhud))
    exit;

var seconds = 0;
var minutes = 0;
var s_str = "";
var m_str = "";

if (global.option_timer_type == 0)
{
    seconds = global.level_seconds;
    minutes = global.level_minutes;
}
else if (global.option_timer_type == 1)
{
    seconds = global.file_seconds;
    minutes = global.file_minutes;
}

var mm = frac(seconds);
mm = string(mm);
mm = string_copy(mm, 3, string_length(mm) - 3);

while (string_length(mm) < 2)
    mm += "0";

while (string_length(mm) > 2)
    mm = string_delete(mm, string_length(mm), 1);

var sd = floor(seconds);

if (sd < 10)
    s_str = concat(0, sd);
else
    s_str = string(sd);

minutes = floor(minutes);
var hours;

for (hours = 0; minutes > 59; hours++)
    minutes -= 60;

if (minutes < 10)
    m_str = concat(0, minutes);
else
    m_str = string(minutes);

if (hours < 10)
    hours = concat(0, hours);
else
    hours = string(hours);

draw_set_halign(fa_right);
draw_set_valign(fa_bottom);
draw_set_font(global.smallfont);
draw_set_alpha(16777215);
draw_text(obj_screensizer.actual_width - 8, obj_screensizer.actual_height - 8, concat(hours, ":", m_str, ":", s_str, ":", mm));
