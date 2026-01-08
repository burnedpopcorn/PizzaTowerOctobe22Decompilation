function string_split(arg0, arg1)
{
    arg0 += " ";
    var _current_str = "";
    var _list = [0];
    
    for (var i = 1; i < (string_length(arg0) + 1); i++)
    {
        var _char = string_char_at(arg0, i);
        
        if (_char != arg1)
            _current_str += _char;
        else
        {
            array_push(_list, _current_str);
            _current_str = "";
        }
    }
    
    return _list;
}

function function_overload(arg0, arg1)
{
    var _size = array_length(arg0);
    
    switch (_size - 1)
    {
        case -1:
            arg1();
            break;
        
        case 0:
            arg1(arg0[0]);
            break;
        
        case 1:
            arg1(arg0[0], arg0[1]);
            break;
        
        case 2:
            arg1(arg0[0], arg0[1], arg0[2]);
            break;
        
        case 3:
            arg1(arg0[0], arg0[1], arg0[2], arg0[3]);
            break;
        
        case 4:
            arg1(arg0[0], arg0[1], arg0[2], arg0[3], arg0[4]);
            break;
        
        case 5:
            arg1(arg0[0], arg0[1], arg0[2], arg0[3], arg0[4], arg0[5]);
            break;
        
        case 6:
            arg1(arg0[0], arg0[1], arg0[2], arg0[3], arg0[4], arg0[5], arg0[6]);
            break;
    }
}

function DebugCommand(arg0, arg1, arg2, arg3) constructor
{
    command_id = arg0;
    description = arg1;
    format = arg2;
    func = arg3;
    
    Invoke = function(arg0)
    {
        if (arg0 != undefined)
            function_overload(arg0, func);
        else
            func();
    };
}

function TextList_Add(arg0, arg1)
{
    with (obj_debugcontroller)
    {
        if (DEBUG)
            ds_list_add(text_list, [arg0, arg1]);
    }
}
