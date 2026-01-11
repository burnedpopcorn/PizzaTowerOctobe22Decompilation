// string_split conflicts with newer GMS2 versions, including LTS
// so yeah, gotta change it a bit
function _string_split(_string, _split)
{
    _string += " ";
    var _current_str = "";
    var _list = [0];
    
    for (var i = 1; i < (string_length(_string) + 1); i++)
    {
        var _char = string_char_at(_string, i);
        
        if (_char != _split)
            _current_str += _char;
        else
        {
            array_push(_list, _current_str);
            _current_str = "";
        }
    }
    
    return _list;
}

function function_overload(_array, _func)
{
    var _size = array_length(_array);
    
    switch (_size - 1)
    {
        case -1:
            _func();
            break;
        
        case 0:
            _func(_array[0]);
            break;
        
        case 1:
            _func(_array[0], _array[1]);
            break;
        
        case 2:
            _func(_array[0], _array[1], _array[2]);
            break;
        
        case 3:
            _func(_array[0], _array[1], _array[2], _array[3]);
            break;
        
        case 4:
            _func(_array[0], _array[1], _array[2], _array[3], _array[4]);
            break;
        
        case 5:
            _func(_array[0], _array[1], _array[2], _array[3], _array[4], _array[5]);
            break;
        
        case 6:
            _func(_array[0], _array[1], _array[2], _array[3], _array[4], _array[5], _array[6]);
            break;
    }
}

function DebugCommand(_id, _desc, _format, _func) constructor
{
    command_id = _id;
    description = _desc;
    format = _format;
    func = _func;
    
    Invoke = function(_args)
    {
        if (_args != undefined)
            function_overload(_args, func);
        else
            func();
    };
}

function TextList_Add(_type, _text)
{
    with (obj_debugcontroller)
    {
        if (DEBUG)
            ds_list_add(text_list, [_type, _text]);
    }
}
