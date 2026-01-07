function Approach(arg0, arg1, arg2)
{
    if (arg0 < arg1)
    {
        arg0 += arg2;
        
        if (arg0 > arg1)
            return arg1;
    }
    else
    {
        arg0 -= arg2;
        
        if (arg0 < arg1)
            return arg1;
    }
    
    return arg0;
}

function get_milliseconds()
{
    return get_timer() / 1000;
}

function camera_zoom(arg0, arg1)
{
    with (obj_camera)
    {
        targetzoom = arg0;
        targetzoom = clamp(targetzoom, 0, max_zoom);
        
        if (arg1 != undefined)
            zoomspd = abs(arg1);
    }
}

function camera_set_zoom(arg0)
{
    with (obj_camera)
        zoom = arg0;
}

function try_solid(arg0, arg1, arg2, arg3)
{
    var old_x = x;
    var old_y = y;
    var n = -1;
    
    for (var i = 0; i < arg3; i++)
    {
        x += arg0;
        y += arg1;
        
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

function ledge_bump(arg0)
{
    var old_x = x;
    var old_y = y;
    x += (xscale * 4);
    var ty = try_solid(0, -1, obj_solid, arg0);
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

function instance_create_unique(arg0, arg1, arg2)
{
    if (instance_exists(arg2))
        return noone;
    
    var b = instance_create(arg0, arg1, arg2);
    return b;
}

function get_solid_difference(arg0, arg1, arg2)
{
    var old_x = x;
    var old_y = y;
    var n = 0;
    
    for (var i = 0; i < arg2; i++)
    {
        x += arg0;
        y += arg1;
        
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

function ds_list_add_unique(arg0)
{
    if (argument_count > 1)
    {
        for (var i = 1; i < argument_count; i++)
        {
            var b = argument[i];
            
            if (ds_list_find_index(arg0, b) == -1)
                ds_list_add(arg0, b);
        }
    }
}

function point_in_camera(arg0, arg1, arg2)
{
    var cam_x = camera_get_view_x(arg2);
    var cam_y = camera_get_view_y(arg2);
    var cam_w = camera_get_view_width(arg2);
    var cam_h = camera_get_view_height(arg2);
    return point_in_rectangle(arg0, arg1, cam_x, cam_y, cam_x + cam_w, cam_y + cam_h);
}

function point_in_camera_ext(arg0, arg1, arg2, arg3, arg4)
{
    var cam_x = camera_get_view_x(arg2);
    var cam_y = camera_get_view_y(arg2);
    var cam_w = camera_get_view_width(arg2);
    var cam_h = camera_get_view_height(arg2);
    return point_in_rectangle(arg0, arg1, cam_x - arg3, cam_y - arg4, cam_x + cam_w + arg3, cam_y + cam_h + arg4);
}

function bbox_in_camera(arg0, arg1)
{
    if (is_undefined(arg1))
        arg1 = 0;
    
    var cam_x = camera_get_view_x(arg0);
    var cam_y = camera_get_view_y(arg0);
    var cam_w = camera_get_view_width(arg0);
    var cam_h = camera_get_view_height(arg0);
    return bbox_left < (cam_x + cam_w + arg1) && bbox_right > (cam_x - arg1) && bbox_top < (cam_y + cam_h + arg1) && bbox_bottom > (cam_y - arg1);
}

function instance_nearest_random(arg0, arg1)
{
    var l = instance_furthest(x, y, arg0);
    var list = ds_list_create();
    
    for (var i = 0; i < instance_number(arg0); i++)
    {
        b = instance_find(arg0, i);
        var t = distance_to_object(b);
        
        if (t <= l)
            ds_list_add(list, b);
    }
    
    var b = undefined;
    
    if (ds_list_size(list) > 0)
    {
        var n = irandom(arg1);
        
        if (ds_list_size(list) < n)
            n = ds_list_size(list) - 1;
        
        b = ds_list_find_value(list, ds_list_size(list) - n);
    }
    
    ds_list_destroy(list);
    return b;
}

function instance_random(arg0)
{
    return instance_find(arg0, irandom(instance_number(arg0) - 1));
}

function heat_calculate(arg0)
{
    return arg0;
}
