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

function lang_get_value(arg0)
{
    return ds_map_find_value(ds_map_find_value(global.lang_map, global.lang), arg0);
}

function lang_parse(arg0)
{
    var list = ds_list_create();
    lang_lexer(list, arg0);
    var map = lang_exec(list);
    var lang = ds_map_find_value(map, "lang");
    ds_map_set(global.lang_map, lang, map);
    ds_list_destroy(list);
}

function lang_lexer(arg0, arg1)
{
    var len = string_length(arg1);
    var pos = 1;
    
    while (pos <= len)
    {
        var start = pos;
        var char = string_ord_at(arg1, pos);
        pos += 1;
        
        switch (char)
        {
            case 32:
            case 9:
            case 13:
            case 10:
                break;
            
            case 35:
                while (pos <= len)
                {
                    char = string_ord_at(arg1, pos);
                    
                    if (char == 13 || char == 10)
                        break;
                    
                    pos += 1;
                }
                
                break;
            
            case 61:
                ds_list_add(arg0, [UnknownEnum.Value_0, start]);
                break;
            
            case 34:
            case 39:
                while (pos <= len)
                {
                    char = string_ord_at(arg1, pos);
                    
                    if (char != 34 && char != 39)
                        pos += 1;
                    else
                        break;
                }
                
                if (pos <= len)
                {
                    var val = string_copy(arg1, start + 1, pos - start - 1);
                    ds_list_add(arg0, [UnknownEnum.Value_2, start, val]);
                    pos += 1;
                }
                else
                {
                    exit;
                }
                
                break;
            
            default:
                if (lang_get_identifier(char, false))
                {
                    while (pos <= len)
                    {
                        char = string_ord_at(arg1, pos);
                        
                        if (lang_get_identifier(char, true))
                            pos += 1;
                        else
                            break;
                    }
                    
                    var name = string_copy(arg1, start, pos - start);
                    
                    switch (name)
                    {
                        case "false":
                            ds_list_add(arg0, [UnknownEnum.Value_3, start, false]);
                            break;
                        
                        case "true":
                            ds_list_add(arg0, [UnknownEnum.Value_3, start, true]);
                            break;
                        
                        default:
                            ds_list_add(arg0, [UnknownEnum.Value_1, start, name]);
                    }
                }
                
                break;
        }
    }
    
    ds_list_add(arg0, [UnknownEnum.Value_4, len + 1]);
}

function lang_get_identifier(arg0, arg1)
{
    if (arg1)
        return arg0 == 95 || (arg0 >= 97 && arg0 <= 122) || (arg0 >= 65 && arg0 <= 90) || (arg0 >= 48 && arg0 <= 57);
    else
        return arg0 == 95 || (arg0 >= 97 && arg0 <= 122) || (arg0 >= 65 && arg0 <= 90);
}

function lang_exec(arg0)
{
    var map = ds_map_create();
    var len = ds_list_size(arg0);
    var pos = 0;
    
    while (pos < len)
    {
        var q = ds_list_find_value(arg0, pos++);
        
        switch (q[0])
        {
            case UnknownEnum.Value_0:
                var ident = array_get(ds_list_find_value(arg0, pos - 2), 2);
                var val = array_get(ds_list_find_value(arg0, pos++), 2);
                ds_map_set(map, ident, val);
                break;
        }
    }
    
    return map;
}

function lang_get_custom_font(arg0, arg1)
{
    var font_map = ds_map_find_value(arg1, concat(arg0, "_map"));
    var font_size = string_length(font_map);
    var font_sep = ds_map_find_value(arg1, concat(arg0, "_sep"));
    font_sep = real(font_sep);
    var font_xorig = 0;
    var font_yorig = 0;
    var spr = sprite_add(concat("lang/", ds_map_find_value(arg1, concat(arg0, "_dir"))), font_size, true, false, font_xorig, font_yorig);
    return font_add_sprite_ext(spr, font_map, false, font_sep);
}

function lang_get_font(arg0)
{
    return ds_map_find_value(global.font_map, lang_get_value(arg0));
}
