if (!ds_exists(tex_list, ds_type_list))
    exit;

var p = tex_max - ds_list_size(tex_list);
var t = (p / tex_max) * spr_gate_plageBG;
draw_healthbar(0, SCREEN_HEIGHT - 4, SCREEN_WIDTH, SCREEN_HEIGHT, t, c_black, c_white, c_white, 0, false, false);
