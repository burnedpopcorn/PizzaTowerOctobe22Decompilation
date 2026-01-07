if (!ds_exists(tex_list, ds_type_list))
    exit;

var p = tex_max - ds_list_size(tex_list);
var t = (p / tex_max) * spr_gate_plageBG;
draw_healthbar(0, obj_screensizer.actual_height - 4, obj_screensizer.actual_width, obj_screensizer.actual_height, t, c_black, c_white, c_white, 0, false, false);
