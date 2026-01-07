function create_transformation_tip(arg0, arg1 = noone)
{
    ini_open_from_string(obj_savesystem.ini_str);
    
    if (arg1 != noone && ini_read_real("Tip", arg1, false))
    {
        ini_close();
        exit;
    }
    
    instance_destroy(obj_transfotip);
    
    with (instance_create(0, 0, obj_transfotip))
        text = arg0;
    
    if (arg1 != noone)
        ini_write_real("Tip", arg1, true);
    
    obj_savesystem.ini_str = ini_close();
}

function scr_compile_icon_text(arg0, arg1 = 1, arg2 = false)
{
    var arr = [];
    var len = string_length(arg0);
    var newline = string_height("ABCDEFGHIJKLMNOPQRSTUVWXYZ");
    var char_x = 0;
    var char_y = 0;
    var saved_pos = 1;
    
    while (arg1 <= len)
    {
        var start = arg1;
        var char = string_ord_at(arg0, arg1);
        
        switch (char)
        {
            case 10:
                char_y += newline;
                char_x = 0;
                break;
            
            case 123:
                var effect = string_copy(arg0, arg1, 3);
                var te = UnknownEnum.Value_1;
                arg1 += 3;
                var n = scr_compile_icon_text(arg0, arg1, true);
                
                switch (effect)
                {
                    case "{s}":
                        te = UnknownEnum.Value_1;
                        break;
                }
                
                array_push(arr, [char_x, char_y, UnknownEnum.Value_2, te, n[0]]);
                arg1 = n[1];
                char_x = n[2];
                char_y = n[3];
                break;
            
            case 91:
                var button = string_copy(arg0, arg1, 3);
                var t = UnknownEnum.Value_1;
                var b = UnknownEnum.Value_0;
                
                switch (button)
                {
                    case "[D]":
                        b = UnknownEnum.Value_3;
                        break;
                    
                    case "[U]":
                        b = UnknownEnum.Value_0;
                        break;
                    
                    case "[M]":
                        b = UnknownEnum.Value_7;
                        break;
                    
                    case "[J]":
                        b = UnknownEnum.Value_8;
                        break;
                    
                    case "[G]":
                        b = UnknownEnum.Value_6;
                        break;
                    
                    case "[F]":
                        b = UnknownEnum.Value_4;
                        break;
                    
                    case "[B]":
                        b = UnknownEnum.Value_5;
                        break;
                    
                    case "[L]":
                        b = UnknownEnum.Value_1;
                        break;
                    
                    case "[R]":
                        b = UnknownEnum.Value_2;
                        break;
                    
                    case "[S]":
                        b = UnknownEnum.Value_9;
                        break;
                }
                
                array_push(arr, [char_x, char_y, t, b]);
                char_x += 32;
                arg1 += 2;
                break;
            
            case 47:
                if (arg2)
                {
                    saved_pos = arg1;
                    arg1 = len + 1;
                }
                
                break;
            
            default:
                while ((arg1 + 1) <= len)
                {
                    char = string_ord_at(arg0, arg1 + 1);
                    
                    if (char != 91 && char != 10 && char != 123 && char != 47)
                        arg1 += 1;
                    else
                        break;
                }
                
                var n = string_copy(arg0, start, (arg1 - start) + 1);
                array_push(arr, [char_x, char_y, UnknownEnum.Value_0, n]);
                char_x += string_width(n);
                break;
        }
        
        arg1 += 1;
    }
    
    if (arg2)
        return [arr, saved_pos, char_x, char_y];
    
    return arr;
}

function scr_text_arr_size(arg0)
{
    var w = 0;
    var newline = string_height("ABCDEFGHIJKLMNOPQRSTUVWXYZ");
    var h = newline;
    
    for (var i = 0; i < array_length(arg0); i++)
    {
        var b = arg0[i];
        var cx = b[0];
        var cy = b[1];
        var t = b[2];
        var val = b[3];
        
        switch (t)
        {
            case UnknownEnum.Value_1:
                if ((cx + 32) > w)
                    w += 32;
                
                break;
            
            case UnknownEnum.Value_2:
                var val2 = b[4];
                var q = scr_text_arr_size(val2);
                
                if ((cy + q[1]) > h)
                    h += (q[1] - newline);
                else if ((cx + q[0]) > w)
                    w += q[0];
                
                break;
            
            case UnknownEnum.Value_0:
                if (cy > h)
                {
                    h += newline;
                }
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

function scr_draw_text_arr(arg0, arg1, arg2, arg3 = c_white, arg4 = 1, arg5 = UnknownEnum.Value_0)
{
    if (arg2 == noone)
        exit;
    
    for (var i = 0; i < array_length(arg2); i++)
    {
        var b = arg2[i];
        var cx = arg0 + b[0];
        var cy = arg1 + b[1];
        var t = b[2];
        var val = b[3];
        
        switch (t)
        {
            case UnknownEnum.Value_1:
                var spr = noone;
                var ix = 0;
                var txt = noone;
                
                if (obj_inputAssigner.player_input_device[0] >= 0)
                {
                    spr = spr_tutorialgamepad;
                    
                    switch (val)
                    {
                        case UnknownEnum.Value_3:
                            ix = 5;
                            break;
                        
                        case UnknownEnum.Value_0:
                            ix = 4;
                            break;
                        
                        case UnknownEnum.Value_7:
                            ix = 9;
                            break;
                        
                        case UnknownEnum.Value_8:
                            ix = 1;
                            break;
                        
                        case UnknownEnum.Value_6:
                            ix = 0;
                            break;
                        
                        case UnknownEnum.Value_4:
                            if (obj_player1.xscale > 0)
                                ix = 17;
                            else
                                ix = 16;
                            
                            break;
                        
                        case UnknownEnum.Value_5:
                            if (obj_player1.xscale > 0)
                                ix = 16;
                            else
                                ix = 17;
                            
                            break;
                        
                        case UnknownEnum.Value_1:
                            ix = 16;
                            break;
                        
                        case UnknownEnum.Value_2:
                            ix = 17;
                            break;
                        
                        case UnknownEnum.Value_9:
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
                        case UnknownEnum.Value_3:
                            arr = scr_get_tutorial_key(global.key_down);
                            break;
                        
                        case UnknownEnum.Value_0:
                            arr = scr_get_tutorial_key(global.key_up);
                            break;
                        
                        case UnknownEnum.Value_7:
                            arr = scr_get_tutorial_key(global.key_attack);
                            break;
                        
                        case UnknownEnum.Value_8:
                            arr = scr_get_tutorial_key(global.key_jump);
                            break;
                        
                        case UnknownEnum.Value_6:
                            arr = scr_get_tutorial_key(global.key_slap);
                            break;
                        
                        case UnknownEnum.Value_4:
                            if (obj_player1.xscale > 0)
                                arr = scr_get_tutorial_key(global.key_right);
                            else
                                arr = scr_get_tutorial_key(global.key_left);
                            
                            break;
                        
                        case UnknownEnum.Value_5:
                            if (obj_player1.xscale > 0)
                                arr = scr_get_tutorial_key(global.key_left);
                            else
                                arr = scr_get_tutorial_key(global.key_right);
                            
                            break;
                        
                        case UnknownEnum.Value_1:
                            arr = scr_get_tutorial_key(global.key_left);
                            break;
                        
                        case UnknownEnum.Value_2:
                            arr = scr_get_tutorial_key(global.key_right);
                            break;
                        
                        case UnknownEnum.Value_9:
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
                
                if (arg5 != UnknownEnum.Value_0)
                {
                    switch (arg5)
                    {
                        case UnknownEnum.Value_1:
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
            
            case UnknownEnum.Value_2:
                var val2 = b[4];
                scr_draw_text_arr(cx, cy, val2, arg3, arg4, val);
                break;
            
            case UnknownEnum.Value_0:
                if (arg5 == UnknownEnum.Value_0)
                {
                    draw_text_color(cx, cy, val, arg3, arg3, arg3, arg3, arg4);
                }
                else
                {
                    var x2 = 0;
                    
                    switch (arg5)
                    {
                        case UnknownEnum.Value_1:
                            for (var j = 1; j <= string_length(val); j++)
                            {
                                var q = string_char_at(val, j);
                                var s1 = irandom_range(-1, 1);
                                var s2 = irandom_range(-1, 1);
                                draw_text_color(cx + x2 + s1, cy + s2, q, arg3, arg3, arg3, arg3, arg4);
                                x2 += string_width(q);
                            }
                            
                            break;
                    }
                }
                
                break;
        }
    }
}
