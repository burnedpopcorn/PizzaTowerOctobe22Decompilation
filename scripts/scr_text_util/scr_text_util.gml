enum textkey
{
	up = 0,
	left = 1,
	right = 2,
	down = 3,
	forwards = 4,
	backwards = 5,
	grab = 6,
	mach = 7,
	jump = 8,
	shoot = 9,
}
enum texteffects
{
	normal = 0,
	shake = 1,
}
enum texttype
{
	normal = 0,		// draw text
	icon = 1,		// draw icons
	array = 2,		// does scr_draw_text_arr within itself
}

function create_transformation_tip(_string, _save_entry = noone)
{
    ini_open_from_string(obj_savesystem.ini_str);
    
    if (_save_entry != noone && ini_read_real("Tip", _save_entry, false))
    {
        ini_close();
        exit;
    }
    
    instance_destroy(obj_transfotip);
    
    with (instance_create(0, 0, obj_transfotip))
        text = _string;
    
    if (_save_entry != noone)
        ini_write_real("Tip", _save_entry, true);
    
    obj_savesystem.ini_str = ini_close();
}

function scr_compile_icon_text(_text, _pos = 1, _return_array = false)
{
    var arr = [];
    var len = string_length(_text);
    var newline = string_height("ABCDEFGHIJKLMNOPQRSTUVWXYZ");
    var char_x = 0;
    var char_y = 0;
    var saved_pos = 1;
    
    while (_pos <= len)
    {
        var start = _pos;
        var char = string_ord_at(_text, _pos);
        
        switch (char)
        {
            case ord("\n"):
                char_y += newline;
                char_x = 0;
                break;
            
            case ord("{"):
                var effect = string_copy(_text, _pos, 3);
                var te = texteffects.shake;
                _pos += 3;
                var n = scr_compile_icon_text(_text, _pos, true);
                
                switch (effect)
                {
                    case "{s}":
                        te = texteffects.shake;
                        break;
                }
                
                array_push(arr, [char_x, char_y, texttype.array, te, n[0]]);
                _pos = n[1];
                char_x = n[2];
                char_y = n[3];
                break;
            
            case ord("["):
                var button = string_copy(_text, _pos, 3);
                var t = texttype.icon;
                var b = textkey.up;
                
                switch (button)
                {
                    case "[D]":
                        b = textkey.down;
                        break;
                    
                    case "[U]":
                        b = textkey.up;
                        break;
                    
                    case "[M]":
                        b = textkey.mach;
                        break;
                    
                    case "[J]":
                        b = textkey.jump;
                        break;
                    
                    case "[G]":
                        b = textkey.grab;
                        break;
                    
                    case "[F]":
                        b = textkey.forwards;
                        break;
                    
                    case "[B]":
                        b = textkey.backwards;
                        break;
                    
                    case "[L]":
                        b = textkey.left;
                        break;
                    
                    case "[R]":
                        b = textkey.right;
                        break;
                    
                    case "[S]":
                        b = textkey.shoot;
                        break;
                }
                
                array_push(arr, [char_x, char_y, t, b]);
                char_x += 32;
                _pos += 2;
                break;
            
            case ord("/"):
                if (_return_array)
                {
                    saved_pos = _pos;
                    _pos = len + 1;
                }
                
                break;
            
            default:
                while ((_pos + 1) <= len)
                {
                    char = string_ord_at(_text, _pos + 1);
                    
                    if (char != ord("[") && char != ord("\n") && char != ord("{") && char != ord("/"))
                        _pos += 1;
                    else
                        break;
                }
                
                var n = string_copy(_text, start, (_pos - start) + 1);
                array_push(arr, [char_x, char_y, texttype.normal, n]);
                char_x += string_width(n);
                break;
        }
        
        _pos += 1;
    }
    
    if (_return_array)
        return [arr, saved_pos, char_x, char_y];
    
    return arr;
}

function scr_text_arr_size(_array)
{
    var w = 0;
    var newline = string_height("ABCDEFGHIJKLMNOPQRSTUVWXYZ");
    var h = newline;
    
    for (var i = 0; i < array_length(_array); i++)
    {
        var b = _array[i];
        var cx = b[0];
        var cy = b[1];
        var t = b[2];
        var val = b[3];
        
        switch (t)
        {
            case texttype.icon:
                if ((cx + 32) > w)
                    w += 32;
                
                break;
            
            case texttype.array:
                var val2 = b[4];
                var q = scr_text_arr_size(val2);
                
                if ((cy + q[1]) > h)
                    h += (q[1] - newline);
                else if ((cx + q[0]) > w)
                    w += q[0];
                
                break;
            
            case texttype.normal:
                if (cy > h)
                    h += newline;
                else
                {
                    var sw = string_width(val);
                    
                    if ((cx + sw) > w)
                        w += string_width(val);
                }
                
                break;
        }
    }
    
    return [w, h];
}

function scr_draw_text_arr(_x, _y, _text_arr, _color = c_white, _alpha = 1, _effect = texteffects.normal)
{
    if (_text_arr == noone)
        exit;
    
    for (var i = 0; i < array_length(_text_arr); i++)
    {
        var b = _text_arr[i];
        var cx = _x + b[0];
        var cy = _y + b[1];
        var t = b[2];
        var val = b[3];
        
        switch (t)
        {
            case texttype.icon:
                var spr = noone;
                var ix = 0;
                var txt = noone;
                
                if (obj_inputAssigner.player_input_device[0] >= 0)
                {
                    spr = spr_tutorialgamepad;
                    
                    switch (val)
                    {
                        case textkey.down:
                            ix = 5;
                            break;
                        
                        case textkey.up:
                            ix = 4;
                            break;
                        
                        case textkey.mach:
                            ix = 9;
                            break;
                        
                        case textkey.jump:
                            ix = 1;
                            break;
                        
                        case textkey.grab:
                            ix = 0;
                            break;
                        
                        case textkey.forwards:
                            if (obj_player1.xscale > 0)
                                ix = 17;
                            else
                                ix = 16;
                            
                            break;
                        
                        case textkey.backwards:
                            if (obj_player1.xscale > 0)
                                ix = 16;
                            else
                                ix = 17;
                            
                            break;
                        
                        case textkey.left:
                            ix = 16;
                            break;
                        
                        case textkey.right:
                            ix = 17;
                            break;
                        
                        case textkey.shoot:
                            ix = 2;
                            break;
                    }
                }
                else
                {
                    spr = spr_tutorialkey;
                    ix = 0;
                    var arr = noone;
                    
                    switch (val)
                    {
                        case textkey.down:
                            arr = scr_get_tutorial_key(global.key_down);
                            break;
                        
                        case textkey.up:
                            arr = scr_get_tutorial_key(global.key_up);
                            break;
                        
                        case textkey.mach:
                            arr = scr_get_tutorial_key(global.key_attack);
                            break;
                        
                        case textkey.jump:
                            arr = scr_get_tutorial_key(global.key_jump);
                            break;
                        
                        case textkey.grab:
                            arr = scr_get_tutorial_key(global.key_slap);
                            break;
                        
                        case textkey.forwards:
                            if (obj_player1.xscale > 0)
                                arr = scr_get_tutorial_key(global.key_right);
                            else
                                arr = scr_get_tutorial_key(global.key_left);
                            
                            break;
                        
                        case textkey.backwards:
                            if (obj_player1.xscale > 0)
                                arr = scr_get_tutorial_key(global.key_left);
                            else
                                arr = scr_get_tutorial_key(global.key_right);
                            
                            break;
                        
                        case textkey.left:
                            arr = scr_get_tutorial_key(global.key_left);
                            break;
                        
                        case textkey.right:
                            arr = scr_get_tutorial_key(global.key_right);
                            break;
                        
                        case textkey.shoot:
                            arr = scr_get_tutorial_key(global.key_shoot);
                            break;
                    }
                    
                    if (arr != noone)
                    {
                        spr = arr[0];
                        ix = arr[1];
                        txt = arr[2];
                    }
                }
                
                if (_effect != texteffects.normal)
                {
                    switch (_effect)
                    {
                        case texteffects.shake:
                            cx += irandom_range(-2, 2);
                            cy += irandom_range(-2, 2);
                            break;
                    }
                }
                
                if (spr != noone)
                {
                    draw_sprite(spr, ix, cx, cy);
                    
                    if (txt != noone)
                    {
                        var f = draw_get_font();
                        draw_set_halign(fa_center);
                        draw_set_valign(fa_middle);
                        draw_set_font(global.tutorialfont);
                        draw_text(cx + 16, cy + 14, txt);
                        draw_set_font(f);
                        draw_set_halign(fa_left);
                        draw_set_valign(fa_top);
                    }
                }
                
                break;
            
            case texttype.array:
                var val2 = b[4];
                scr_draw_text_arr(cx, cy, val2, _color, _alpha, val);
                break;
            
            case texttype.normal:
                if (_effect == texteffects.normal)
                    draw_text_color(cx, cy, val, _color, _color, _color, _color, _alpha);
                else
                {
                    var x2 = 0;
                    
                    switch (_effect)
                    {
                        case texteffects.shake:
                            for (var j = 1; j <= string_length(val); j++)
                            {
                                var q = string_char_at(val, j);
                                var s1 = irandom_range(-1, 1);
                                var s2 = irandom_range(-1, 1);
                                draw_text_color(cx + x2 + s1, cy + s2, q, _color, _color, _color, _color, _alpha);
                                x2 += string_width(q);
                            }
                            
                            break;
                    }
                }
                
                break;
        }
    }
}
