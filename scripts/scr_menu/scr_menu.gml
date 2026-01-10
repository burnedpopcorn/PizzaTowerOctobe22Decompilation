enum menutype
{
	toggle = 0,
	multiple = 1,
	press = 2,
	slide = 3,
}

function menu_goto(arg0)
{
    menu = 0;
    
    for (var i = 0; i < array_length(menus); i++)
    {
        var b = menus[i];
        
        if (b.menu_id == arg0)
        {
            menu = i;
            break;
        }
    }
    
    optionselected = 0;
}

function create_menu_fixed(arg0, arg1, arg2, arg3)
{
    return 
    {
        menu_id: arg0,
        type: menutype.toggle,
        anchor: arg1,
        xpad: arg2,
        ypad: arg3,
        options: []
    };
}

function add_option_press(arg0, arg1, arg2, arg3)
{
    var b = 
    {
        option_id: arg1,
        type: menutype.press,
        func: arg3,
        name: arg2
    };
    array_push(arg0.options, b);
    return b;
}

function add_option_toggle(arg0, arg1, arg2, arg3 = noone)
{
    var b = 
    {
        option_id: arg1,
        type: menutype.toggle,
        value: false,
        name: arg2,
        on_changed: arg3
    };
    array_push(arg0.options, b);
    return b;
}

function add_option_multiple(arg0, arg1, arg2, arg3, arg4 = noone)
{
    var b = 
    {
        option_id: arg1,
        type: menutype.multiple,
        values: arg3,
        value: 0,
        name: arg2,
        on_changed: arg4
    };
    array_push(arg0.options, b);
    return b;
}

function create_option_value(arg0, arg1, arg2 = true)
{
    return 
    {
        name: arg0,
        value: arg1,
        localization: arg2
    };
}

function add_option_slide(arg0, arg1, arg2, arg3 = noone)
{
    var b = 
    {
        option_id: arg1,
        type: menutype.slide,
        value: 100,
        moved: false,
        name: arg2,
        on_changed: arg3
    };
    array_push(arg0.options, b);
    return b;
}
