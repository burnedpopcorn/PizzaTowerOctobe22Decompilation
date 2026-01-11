#macro ANIMATION_ENDED floor(image_index) == (image_number - 1)
#macro ANIMATION_PLAYING floor(image_index) != (image_number - 1)

function Approach(a, b, amount)
{
    if (a < b)
    {
        a += amount;
        if (a > b)
            return b;
    }
    else
    {
        a -= amount;
        if (a < b)
            return b;
    }
    return a;
}

function get_milliseconds()
{
    return get_timer() / 1000;
}

function camera_zoom(_zoom, _speed)
{
    with (obj_camera)
    {
        targetzoom = _zoom;
        targetzoom = clamp(targetzoom, 0, max_zoom);
        
        if (_speed != undefined)
            zoomspd = abs(_speed);
    }
}

function camera_set_zoom(_zoom)
{
    with (obj_camera)
        zoom = _zoom;
}

//_obj isn't used in the function, but this function is still used a lot in the code
// so its probably still here and needed because of lazyness
function try_solid(_xoff, _yoff, _obj, _iterations)
{
    var old_x = x;
    var old_y = y;
    var n = -1;
    
    for (var i = 0; i < _iterations; i++)
    {
        x += _xoff;
        y += _yoff;
        
        if (!scr_solid(x, y))
        {
            n = i + 1;
            break;
        }
    }
    
    x = old_x;
    y = old_y;
    return n;
}

function ledge_bump(_iterations)
{
    var old_x = x;
    var old_y = y;
    x += (xscale * 4);
    var ty = try_solid(0, -1, obj_solid, _iterations);
    x = old_x;
    
    if (ty != -1)
    {
        y -= ty;
        x += xscale;
        
        if (scr_solid(x, y))
        {
            x = old_x;
            y = old_y;
            return true;
        }
        
        return false;
    }
    
    return true;
}

function instance_create_unique(_x, _y, _obj)
{
    if (instance_exists(_obj))
        return noone;
    
    var b = instance_create(_x, _y, _obj);
    return b;
}

function get_solid_difference(_xoff, _yoff, _dist)
{
    var old_x = x;
    var old_y = y;
    var n = 0;
    
    for (var i = 0; i < _dist; i++)
    {
        x += _xoff;
        y += _yoff;
        
        if (!scr_solid(x, y))
            n++;
    }
    
    x = old_x;
    y = old_y;
    return n;
}

function trace()
{
    var _string = "";
    
    for (var i = 0; i < argument_count; i++)
        _string += string(argument[i]);
    
    show_debug_message(_string);
}

function concat()
{
    var _string = "";
    
    for (var i = 0; i < argument_count; i++)
        _string += string(argument[i]);
    
    return _string;
}

function ds_list_add_unique(_list)
{
    if (argument_count > 1)
    {
        for (var i = 1; i < argument_count; i++)
        {
            var b = argument[i];
            
            if (ds_list_find_index(_list, b) == -1)
                ds_list_add(_list, b);
        }
    }
}

function point_in_camera(_x, _y, _cam)
{
    var cam_x = camera_get_view_x(_cam);
    var cam_y = camera_get_view_y(_cam);
    var cam_w = camera_get_view_width(_cam);
    var cam_h = camera_get_view_height(_cam);
    return point_in_rectangle(_x, _y, cam_x, cam_y, cam_x + cam_w, cam_y + cam_h);
}

function point_in_camera_ext(_x, _y, _cam, _width, _height)
{
    var cam_x = camera_get_view_x(_cam);
    var cam_y = camera_get_view_y(_cam);
    var cam_w = camera_get_view_width(_cam);
    var cam_h = camera_get_view_height(_cam);
    return point_in_rectangle(_x, _y, cam_x - _width, cam_y - _height, cam_x + cam_w + _width, cam_y + cam_h + _height);
}

function bbox_in_camera(_cam, _padding)
{
    if (is_undefined(_padding))
        _padding = 0;
    
    var cam_x = camera_get_view_x(_cam);
    var cam_y = camera_get_view_y(_cam);
    var cam_w = camera_get_view_width(_cam);
    var cam_h = camera_get_view_height(_cam);
    return bbox_left < (cam_x + cam_w + _padding) && bbox_right > (cam_x - _padding) && bbox_top < (cam_y + cam_h + _padding) && bbox_bottom > (cam_y - _padding);
}

function instance_nearest_random(_obj, _range)
{
    var l = instance_furthest(x, y, _obj);
    var list = ds_list_create();
    
    for (var i = 0; i < instance_number(_obj); i++)
    {
        b = instance_find(_obj, i);
        var t = distance_to_object(b);
        
        if (t <= l)
            ds_list_add(list, b);
    }
    
    var b = undefined;
    
    if (ds_list_size(list) > 0)
    {
        var n = irandom(_range);
        
        if (ds_list_size(list) < n)
            n = ds_list_size(list) - 1;
        
        b = list[| ds_list_size(list) - n];
    }
    
    ds_list_destroy(list);
    return b;
}

function instance_random(_obj)
{
    return instance_find(_obj, irandom(instance_number(_obj) - 1));
}

function heat_calculate(_value)
{
    return _value;
}
