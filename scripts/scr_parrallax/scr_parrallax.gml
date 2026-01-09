function calculate_parrallax_still_x(arg0, arg1)
{
    var _cam_x = camera_get_view_x(view_camera[0]);
    var lay = layer_get_id(arg0);
    var w = room_width - SCREEN_WIDTH;
    var per_x;
    
    if (room_width <= SCREEN_WIDTH)
        per_x = 0;
    else
        per_x = _cam_x / w;
    
    var si = layer_background_get_sprite(layer_background_get_id(lay));
    var sw = sprite_get_width(si) - SCREEN_WIDTH;
    var r = sw * per_x * arg1;
    r = max(r, 0);
    return r;
}

function calculate_parrallax_still_y(arg0, arg1)
{
    var _cam_y = camera_get_view_y(view_camera[0]);
    var lay = arg0;
    var h = room_height - SCREEN_HEIGHT;
    var per_y;
    
    if (room_height <= SCREEN_HEIGHT)
        per_y = 0;
    else
        per_y = _cam_y / h;
    
    var si = layer_background_get_sprite(layer_background_get_id(lay));
    var sh = sprite_get_height(si) - SCREEN_HEIGHT;
    var r = sh * per_y * arg1;
    r = max(r, 0);
    return r;
}
