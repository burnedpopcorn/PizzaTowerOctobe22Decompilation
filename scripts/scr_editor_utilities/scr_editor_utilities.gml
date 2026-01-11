function sprite_set_size(_width, _height)
{
    image_xscale = _width / sprite_get_width(sprite_index);
    image_yscale = _height / sprite_get_width(sprite_index);
}

function snap_tile(_value, _snap)
{
    return floor(_value / _snap) * _snap;
}

function add_object(_type, _name, _sprite, _obj, _xoff = 0, _yoff = 0)
{
    var s = 1;
    
    if (sprite_get_width(_sprite) >= 64 || sprite_get_height(_sprite) >= 64)
        s = min(64 / sprite_get_width(_sprite), 64 / sprite_get_height(_sprite));
    
    ds_list_add(object_list[_type], 
    {
        name: _name,
        sprite_index: _sprite,
        image_xscale: s,
        image_yscale: s,
        object_index: _obj,
        image_xoffset: _xoff,
        image_yoffset: _yoff,
        place_xoffset: 0,
        place_yoffset: 0,
        layerdepth: 0
    });
}

function set_object_place_offset(_obj, _offset, _unused)
{
    var b = ds_list_find_value(array_get(object_list, _obj), ds_list_size(objectlist) - 1);
    b.place_xoffset = _offset;
    b.place_yoffset = _offset;
}

function set_object_layerdepth(_obj, _depth)
{
    var b = ds_list_find_value(array_get(object_list, _obj), ds_list_size(objectlist) - 1);
    b.layerdepth = _depth;
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

function create_buttons_array(_x, _y, _width, _height, _array)
{
    var xsize = 0;
    draw_set_font(global.editorfont);
    
    for (var i = 0; i < array_length(_array); i++)
    {
        var b = _array[i];
        var t = string_width(b[0]);
        
        if (t > xsize)
            xsize = t + _width;
    }
    
    for (var i = 0; i < array_length(_array); i++)
    {
        var b = _array[i];
        
        with (instance_create_depth(_x, _y + (i * _height), depth, obj_textbutton))
        {
            buttonid = i;
            sprite_index = spr_bigbutton;
            sprite_set_size(xsize, _height);
            label = b[0];
            
            if (b[1] != noone)
                OnSelect = method(id, b[1]);
            
            if (b[2] != noone)
                OnDeselect = method(id, b[2]);
            
            parent = other.id;
        }
    }
}
