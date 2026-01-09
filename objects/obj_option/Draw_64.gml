if (instance_exists(obj_keyconfig))
    exit;

draw_rectangle_color(0, 0, obj_screensizer.actual_width, obj_screensizer.actual_height, c_black, c_black, c_black, c_black, false);
draw_set_font(lang_get_font("bigfont"));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
var _os = optionselected;
var m = menus[menu];
var options = m.options;
var len = array_length(options);
var size = (string_height("A") * len) + (len * m.ypad);
var xx = obj_screensizer.actual_width / 2;
var yy = (obj_screensizer.actual_height / 2) - (size / 4);

switch (m.anchor)
{
    case menuanchors.center:
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        var c = c_white;
        
        for (var i = 0; i < len; i++)
        {
            var o = options[i];
            var a = 0.5;
            
            if (i == _os)
                a = 1;
            
            draw_text_color(xx, yy + (m.ypad * i), lang_get_value(o.name), c, c, c, c, a);
        }
        
        break;
    
    case menuanchors.left:
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        xx = m.xpad;
        var c = c_white;
        
        for (var i = 0; i < len; i++)
        {
            draw_set_halign(fa_left);
            var o = options[i];
            var a = 0.5;
            
            if (i == _os)
                a = 1;
            
            draw_text_color(xx, yy + (m.ypad * i), lang_get_value(o.name), c, c, c, c, a);
            draw_set_halign(fa_right);
            
            switch (o.type)
            {
                case menutype.toggle:
                    draw_text_color(obj_screensizer.actual_width - m.xpad, yy + (m.ypad * i), o.value ? lang_get_value("option_on") : lang_get_value("option_off"), c, c, c, c, a);
                    break;
                
                case menutype.slide:
                    draw_text_color(obj_screensizer.actual_width - m.xpad, yy + (m.ypad * i), o.value, c, c, c, c, a);
                    break;
                
                case menutype.multiple:
                    var select = o.values[o.value];
                    var n = select.name;
                    
                    if (select.localization)
                        n = lang_get_value(select.name);
                    
                    draw_text_color(obj_screensizer.actual_width - m.xpad, yy + (m.ypad * i), n, c, c, c, c, a);
                    break;
            }
        }
        
        break;
}
