function scr_destroy_tiles(_size, _layer, _spread = 0)
{
    var lay_id = layer_get_id(_layer);
    
    if (lay_id != -1)
    {
        var map_id = layer_tilemap_get_id(lay_id);
        var w = abs(sprite_width) / _size;
        var h = abs(sprite_height) / _size;
        var ix = sign(image_xscale);
        var iy = sign(image_yscale);
        
        if (ix < 0)
            w++;
        
        var yy = 0 - _spread;
        
        while (yy < (h + _spread))
        {
            var xx = 0 - _spread;
            
            while (xx < (w + _spread))
            {
                scr_destroy_tile(x + (xx * _size * ix), y + (yy * _size * iy), map_id);
                xx++;
            }
            
            yy++;
        }
    }
}

function scr_destroy_tile_arr(_size, _array, _spread = 0)
{
    for (var i = 0; i < array_length(_array); i++)
        scr_destroy_tiles(_size, _array[i], _spread);
}

function scr_destroy_tile(_x, _y, _tilemap)
{
    var data = tilemap_get_at_pixel(_tilemap, _x, _y);
    data = tile_set_empty(data);
    tilemap_set_at_pixel(_tilemap, data, _x, _y);
}

function scr_solid_line(_obj)
{
    if (collision_line(x, y, _obj.x, _obj.y, obj_solid, false, true) != noone)
        return true;
    
    if (collision_line(x, y, _obj.x, _obj.y, obj_slope, false, true) != noone)
        return true;
    
    return false;
}

function scr_destroy_nearby_tiles()
{
    instance_destroy(instance_place(x + 1, y, obj_tiledestroy));
    instance_destroy(instance_place(x - 1, y, obj_tiledestroy));
    instance_destroy(instance_place(x, y + 1, obj_tiledestroy));
    instance_destroy(instance_place(x, y - 1, obj_tiledestroy));
}

function scr_cutoff()
{
    with (instance_place(x, y, obj_cutoff))
        instance_destroy();
    
    var dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    
    for (var i = 0; i < array_length(dirs); i++)
    {
        var d = dirs[i];
        
        if (!place_meeting(x + d[0], y + d[1], obj_cutoff))
            continue;
        
        var num = instance_place_list(x + d[0], y + d[1], obj_cutoff, global.instancelist, false);
        
        for (var j = 0; j < num; j++)
        {
            var b = global.instancelist[| j];
            
            with (b)
            {
                if (!place_meeting(x, y, obj_solid))
                    instance_destroy();
                else if (other.object_index == obj_tiledestroy || ((object_index != obj_cutoffsmall || other.object_index == obj_secretblock) && (object_index != obj_cutoff || (other.object_index == obj_secretbigblock || other.object_index == obj_secretmetalblock))))
                {
                    var a = scr_cutoff_get_angle(b);
                    var da = a;
                    
                    if (d[0] == -1)
                        da = 0;
                    else if (d[0] == 1)
                        da = 180;
                    else if (d[1] == -1)
                        da = 270;
                    else if (d[1] == 1)
                        da = 90;
                    
                    if (a == da)
                        visible = true;
                }
            }
        }
        
        ds_list_clear(global.instancelist);
    }
    
    ds_list_clear(global.instancelist);
}

function scr_cutoff_get_angle(_obj)
{
    var a = _obj.image_angle + 90;
    var d = point_direction(0, 0, lengthdir_x(1, a) * _obj.image_yscale, lengthdir_y(1, a) * _obj.image_yscale);
    return d;
}
