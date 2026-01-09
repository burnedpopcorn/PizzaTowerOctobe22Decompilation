function declare_particle(arg0, arg1, arg2, arg3)
{
    ds_map_set(global.part_map, arg0, part_type_create());
    ds_map_set(global.part_depth, arg0, arg3);
    var p = ds_map_find_value(global.part_map, arg0);
    part_type_sprite(p, arg1, true, true, false);
    var t = sprite_get_number(arg1);
    var s = arg2;
    var spd = t / s;
    part_type_life(p, spd, spd);
    return p;
}

function particle_set_scale(arg0, arg1, arg2)
{
    part_type_scale(ds_map_find_value(global.part_map, arg0), arg1, arg2);
}

function create_debris(arg0, arg1, arg2, arg3 = false)
{
    var q = 
    {
        x: arg0,
        y: arg1,
        sprite_index: arg2,
        image_number: sprite_get_number(arg2),
        image_index: irandom(image_number - 1),
        image_angle: random_range(1, 270),
        image_speed: 0.35,
        sprw: sprite_get_width(arg2),
        sprh: sprite_get_height(arg2),
        hsp: random_range(-4, 4),
        vsp: random_range(-5, -2),
        alpha: 1,
        grav: 0.4,
        type: particle_type.normal,
        animated: arg3,
        destroyonanimation: false
    };
    ds_list_add(global.debris_list, q);
    return q;
}

function create_heatpuff(arg0, arg1)
{
    var q = create_debris(arg0, arg1, spr_heatpuff, true);
    q.grav = 0;
    q.hsp = 0;
    q.vsp = irandom_range(-4, -1);
    q.destroyonanimation = true;
    return q;
}

function create_collect(arg0, arg1, arg2)
{
    arg0 -= camera_get_view_x(view_camera[0]);
    arg1 -= camera_get_view_y(view_camera[0]);
    var q = 
    {
        x: arg0,
        y: arg1,
        sprite_index: arg2,
        image_index: 0,
        image_number: sprite_get_number(arg2),
        hsp: 0,
        vsp: 0
    };
    ds_list_add(global.collect_list, q);
    return q;
}

function create_particle(arg0, arg1, arg2, arg3 = 0)
{
    if (arg3 == undefined)
        arg3 = 0;
    
    var _depth = ds_map_find_value(global.part_depth, arg2);
    
    if (is_undefined(_depth))
        _depth = object_get_depth(object_index);
    
    part_system_depth(global.particle_system, _depth);
    part_emitter_region(global.particle_system, global.part_emitter, arg0 - arg3, arg0 + arg3, arg1 - arg3, arg1 + arg3, 0, 0);
    part_emitter_burst(global.particle_system, global.part_emitter, ds_map_find_value(global.part_map, arg2), 1);
}
