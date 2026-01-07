function sprite_set_size(arg0, arg1)
{
    image_xscale = arg0 / sprite_get_width(sprite_index);
    image_yscale = arg1 / sprite_get_width(sprite_index);
}

function snap_tile(arg0, arg1)
{
    return floor(arg0 / arg1) * arg1;
}

function add_object(arg0, arg1, arg2, arg3, arg4 = 0, arg5 = 0)
{
    var s = 1;
    
    if (sprite_get_width(arg2) >= 64 || sprite_get_height(arg2) >= 64)
        s = min(64 / sprite_get_width(arg2), 64 / sprite_get_height(arg2));
    
    ds_list_add(object_list[arg0], 
    {
        name: arg1,
        sprite_index: arg2,
        image_xscale: s,
        image_yscale: s,
        object_index: arg3,
        image_xoffset: arg4,
        image_yoffset: arg5,
        place_xoffset: 0,
        place_yoffset: 0,
        layerdepth: 0
    });
}

function set_object_place_offset(arg0, arg1, arg2)
{
    var b = ds_list_find_value(array_get(object_list, arg0), ds_list_size(objectlist) - 1);
    b.place_xoffset = arg1;
    b.place_yoffset = arg1;
}

function set_object_layerdepth(arg0, arg1)
{
    var b = ds_list_find_value(array_get(object_list, arg0), ds_list_size(objectlist) - 1);
    b.layerdepth = arg1;
}

function objectlist_calculate_scrollsize()
{
    var xx = 0;
    var yy = 0;
    
    for (var i = 0; i < ds_list_size(object_list); i++)
    {
        xx += 64;
        
        if (xx >= sprite_width)
        {
            xx = 0;
            yy += 64;
        }
    }
    
    scroll_ymax = yy - sprite_height;
    
    if (scroll_ymax < 0)
        scroll_ymax = 0;
}

function create_buttons_array(arg0, arg1, arg2, arg3, arg4)
{
    var xsize = 0;
    draw_set_font(global.editorfont);
    
    for (var i = 0; i < array_length(arg4); i++)
    {
        var b = arg4[i];
        var t = string_width(b[0]);
        
        if (t > xsize)
            xsize = t + arg2;
    }
    
    for (var i = 0; i < array_length(arg4); i++)
    {
        var b = arg4[i];
        
        with (instance_create_depth(arg0, arg1 + (i * arg3), depth, obj_textbutton))
        {
            buttonid = i;
            sprite_index = spr_bigbutton;
            sprite_set_size(xsize, arg3);
            label = b[0];
            
            if (b[1] != noone)
                OnSelect = method(id, b[1]);
            
            if (b[2] != noone)
                OnDeselect = method(id, b[2]);
            
            parent = other.id;
        }
    }
}
