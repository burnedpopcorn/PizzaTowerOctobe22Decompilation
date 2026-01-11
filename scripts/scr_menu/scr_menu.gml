enum menutype
{
	toggle = 0,
	multiple = 1,
	press = 2,
	slide = 3,
}

function menu_goto(_menuID)
{
    menu = 0;
    
    for (var i = 0; i < array_length(menus); i++)
    {
        var b = menus[i];
        
        if (b.menu_id == _menuID)
        {
            menu = i;
            break;
        }
    }
    
    optionselected = 0;
}

function create_menu_fixed(_menuID, _anchor, _xpad, _ypad)
{
    return 
    {
        menu_id: _menuID,
        type: menutype.toggle,
        anchor: _anchor,
        xpad: _xpad,
        ypad: _ypad,
        options: []
    };
}

function add_option_press(_menu, _optionID, _name, _func)
{
    var b = 
    {
        option_id: _optionID,
        type: menutype.press,
        func: _func,
        name: _name
    };
    array_push(_menu.options, b);
    return b;
}

function add_option_toggle(_menu, _optionID, _name, _on_changed = noone)
{
    var b = 
    {
        option_id: _optionID,
        type: menutype.toggle,
        value: false,
        name: _name,
        on_changed: _on_changed
    };
    array_push(_menu.options, b);
    return b;
}

function add_option_multiple(_menu, _optionID, _name, _values, _on_changed = noone)
{
    var b = 
    {
        option_id: _optionID,
        type: menutype.multiple,
        values: _values,
        value: 0,
        name: _name,
        on_changed: _on_changed
    };
    array_push(_menu.options, b);
    return b;
}

function create_option_value(_name, _value, _localization = true)
{
    return 
    {
        name: _name,
        value: _value,
        localization: _localization
    };
}

function add_option_slide(_menu, _optionID, _name, _on_changed = noone)
{
    var b = 
    {
        option_id: _optionID,
        type: menutype.slide,
        value: 100,
        moved: false,
        name: _name,
        on_changed: _on_changed
    };
    array_push(_menu.options, b);
    return b;
}
