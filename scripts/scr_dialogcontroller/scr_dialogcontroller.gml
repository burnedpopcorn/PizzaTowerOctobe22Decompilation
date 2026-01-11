function scr_get_tutorial_key(_key)
{
    var spr = noone;
    var ix = 0;
    var txt = noone;
    
    switch (_key)
    {
        case vk_left:
            spr = spr_tutorialgamepad;
            ix = 16;
            break;
        
        case vk_right:
            spr = spr_tutorialgamepad;
            ix = 17;
            break;
        
        case vk_up:
            spr = spr_tutorialgamepad;
            ix = 4;
            break;
        
        case vk_down:
            spr = spr_tutorialgamepad;
            ix = 5;
            break;
        
        case vk_shift:
        case vk_lshift:
            spr = spr_tutorialkeyspecial;
            ix = 0;
            break;
        
        case vk_control:
        case vk_lcontrol:
            spr = spr_tutorialkeyspecial;
            ix = 1;
            break;
        
        case vk_space:
            spr = spr_tutorialkeyspecial;
            ix = 2;
            break;
        
        default:
            spr = spr_tutorialkey;
            ix = 0;
            txt = chr(_key);
            break;
    }
    
    return [spr, ix, txt];
}

function scr_string_width(_string)
{
    var pos = 0;
    var w = 0;
    var originalstr = _string;
    var str_arr = array_create(0);
    
    while (pos < string_length(originalstr))
    {
        if (string_copy(originalstr, pos, 2) == "\n")
        {
            array_push(str_arr, string_copy(originalstr, 1, pos));
            string_delete(originalstr, 1, pos);
            pos = 0;
            
            if (originalstr == "")
                break;
        }
        else
            pos++;
    }
    
    if (array_length(str_arr) == 0)
        w = string_width(_string);
    
    for (var i = 0; i < array_length(str_arr); i++)
    {
        var b = str_arr[i];
        
        if (string_width(b) > w)
            w = string_width(b);
    }
    
    return w;
}

function scr_separate_text(_string, _font, _width)
{
    draw_set_font(_font);
    
    while (scr_string_width(_string) > (_width - string_width("a")))
    {
        var _pos = string_length(_string);
        var _oldpos = _pos;
        
        while (string_char_at(_string, _pos) != " ")
        {
            _pos--;
            
            if (_pos < 0)
                _pos = _oldpos;
        }
        
        if (string_char_at(_string, _pos) == " ")
            _string = string_delete(_string, _pos, 1);
        
        _string = string_insert("\n", _string, _pos);
    }
    
    return _string;
}

function scr_calculate_text(_text)
{
    draw_set_font(font2);
    var pos = 0;
    var str2 = "";
    
    while (pos <= string_length(_text))
    {
        pos++;
        str2 = string_insert(string_char_at(_text, pos), str2, string_length(str2) + 1);
        str2 = scr_separate_text(str2);
    }
    
    return str2;
}

function scr_calculate_height(_text)
{
    var str2 = scr_calculate_text(_text);
    return string_height(str2);
}
