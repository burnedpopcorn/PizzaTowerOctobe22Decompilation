function scr_get_languages()
{
    global.lang_map = ds_map_create();
    global.lang = "en";
    var arr = [];
    var file = file_find_first("lang/*.txt", 0);
    
    while (file != "")
    {
        array_push(arr, file);
        file = file_find_next();
    }
    
    file_find_close();
    
    for (var i = 0; i < array_length(arr); i++)
    {
        var fo = file_text_open_read("lang/" + arr[i]);
        var str = "";
        
        while (!file_text_eof(fo))
        {
            str += file_text_readln(fo);
            str += "\n";
        }
        
        file_text_close(fo);
        lang_parse(str);
    }
}

function lang_get_value(_entry)
{
    return global.lang_map[? global.lang][? _entry];
}

function lang_parse(_langstring)
{
    var list = ds_list_create();
    lang_lexer(list, _langstring);
    var map = lang_exec(list);
    var lang = map[? "lang"];
    global.lang_map[? lang] = map;
    ds_list_destroy(list);
}

enum lexer
{
	set = 0,
	name = 1,
	value = 2,
	keyword = 3,
	eof = 4,
}

function lang_lexer(_list, _string)
{
    var len = string_length(_string);
    var pos = 1;
    
    while (pos <= len)
    {
        var start = pos;
        var char = string_ord_at(_string, pos);
        pos += 1;
        
        switch (char)
        {
            case ord(" "):
            case ord("	"):
            case ord("\r"):
            case ord("\n"):
                break;
            
            case ord("#"):
                while (pos <= len)
                {
                    char = string_ord_at(_string, pos);
                    
                    if (char == ord("\r") || char == ord("\n"))
                        break;
                    
                    pos += 1;
                }
                
                break;
            
            case ord("="):
                ds_list_add(_list, [lexer.set, start]);
                break;
            
            case ord("\""):
            case ord("'"):// might be ord("\\") idk //39
                while (pos <= len)
                {
                    char = string_ord_at(_string, pos);
                    
                    if (char != ord("\"") && char != ord("'"))
                        pos += 1;
                    else
                        break;
                }
                
                if (pos <= len)
                {
                    var val = string_copy(_string, start + 1, pos - start - 1);
                    ds_list_add(_list, [lexer.value, start, val]);
                    pos += 1;
                }
                else
                    exit;
                
                break;
            
            default:
                if (lang_get_identifier(char, false))
                {
                    while (pos <= len)
                    {
                        char = string_ord_at(_string, pos);
                        
                        if (lang_get_identifier(char, true))
                            pos += 1;
                        else
                            break;
                    }
                    
                    var name = string_copy(_string, start, pos - start);
                    
                    switch (name)
                    {
                        case "false":
                            ds_list_add(_list, [lexer.keyword, start, false]);
                            break;
                        
                        case "true":
                            ds_list_add(_list, [lexer.keyword, start, true]);
                            break;
                        
                        default:
                            ds_list_add(_list, [lexer.name, start, name]);
                    }
                }
                
                break;
        }
    }
    
    ds_list_add(_list, [lexer.eof, len + 1]);
}

function lang_get_identifier(_keycode, _allow_numbers)
{
    if (_allow_numbers)
        return _keycode == ord("_") || (_keycode >= ord("a") && _keycode <= ord("z")) || (_keycode >= ord("A") && _keycode <= ord("Z")) || (_keycode >= ord("0") && _keycode <= ord("9"));
    else
        return _keycode == ord("_") || (_keycode >= ord("a") && _keycode <= ord("z")) || (_keycode >= ord("A") && _keycode <= ord("Z"));
}

function lang_exec(_list)
{
    var map = ds_map_create();
    var len = ds_list_size(_list);
    var pos = 0;
    
    while (pos < len)
    {
        var q = _list[| pos++];
        
        switch (q[0])
        {
            case lexer.set:
                var ident = array_get(_list[| pos - 2], 2);
                var val = array_get(_list[| pos++], 2);
                map[? ident] = val;
                break;
        }
    }
    
    return map;
}

function lang_get_custom_font(_fontname, _language)
{
    var font_map = _language[? concat(_fontname, "_map")];
    var font_size = string_length(font_map);
    var font_sep = _language[? concat(_fontname, "_sep")];
    font_sep = real(font_sep);
    var font_xorig = 0;
    var font_yorig = 0;
    var spr = sprite_add(concat("lang/", _language[? concat(_fontname, "_dir")]), font_size, true, false, font_xorig, font_yorig);
    return font_add_sprite_ext(spr, font_map, false, font_sep);
}

function lang_get_font(_fontname)
{
    return global.font_map[? lang_get_value(_fontname)];
}
