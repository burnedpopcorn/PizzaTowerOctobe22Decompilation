function scr_destroy_tiles(arg0, arg1, arg2 = 0)
{
    var lay_id = layer_get_id(arg1);
    
    if (lay_id != -1)
    {
        var map_id = layer_tilemap_get_id(lay_id);
        var w = abs(sprite_width) / arg0;
        var h = abs(sprite_height) / arg0;
        var ix = sign(image_xscale);
        var iy = sign(image_yscale);
        
        if (ix < 0)
            w++;
        
        var yy = 0 - arg2;
        
        while (yy < (h + arg2))
        {
            var xx = 0 - arg2;
            
            while (xx < (w + arg2))
            {
                scr_destroy_tile(x + (xx * arg0 * ix), y + (yy * arg0 * iy), map_id);
                xx++;
            }
            
            yy++;
        }
    }
}

function scr_destroy_tile_arr(arg0, arg1, arg2 = 0)
{
    for (var i = 0; i < array_length(arg1); i++)
        scr_destroy_tiles(arg0, arg1[i], arg2);
}

function scr_destroy_tile(arg0, arg1, arg2)
{
    var data = tilemap_get_at_pixel(arg2, arg0, arg1);
    data = tile_set_empty(data);
    tilemap_set_at_pixel(arg2, data, arg0, arg1);
}

function scr_solid_line(arg0)
{
    if (collision_line(x, y, arg0.x, arg0.y, obj_solid, false, true) != noone)
        return true;
    
    if (collision_line(x, y, arg0.x, arg0.y, obj_slope, false, true) != noone)
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
            var b = ds_list_find_value(global.instancelist, j);
            
            with (b)
            {
                if (!place_meeting(x, y, obj_solid))
                {
                    instance_destroy();
                }
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

function scr_cutoff_get_angle(arg0)
{
    var a = arg0.image_angle + 90;
    var d = point_direction(0, 0, lengthdir_x(1, a) * arg0.image_yscale, lengthdir_y(1, a) * arg0.image_yscale);
    return d;
}
