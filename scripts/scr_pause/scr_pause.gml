function scr_pause_activate_objects()
{
    for (var i = 0; i < ds_list_size(instance_list); i++)
        instance_activate_object(array_get(ds_list_find_value(instance_list, i), 0));
    
    ds_list_clear(instance_list);
    audio_resume_all();
    fadein = false;
    pause = false;
    alarm[2] = 1;
}

function scr_pause_deactivate_objects()
{
    ds_list_clear(instance_list);
    
    for (var i = 0; i < instance_count; i++)
    {
        var obj = instance_find(-3, i);
        
        if (instance_exists(obj) && obj.object_index != obj_pause && obj.object_index != obj_inputAssigner && obj.object_index != obj_screensizer)
            ds_list_add(instance_list, [obj, obj.object_index]);
    }
    
    instance_deactivate_all(true);
    instance_activate_object(obj_inputAssigner);
    instance_activate_object(obj_screensizer);
    instance_activate_object(obj_music);
    instance_activate_object(obj_fmod);
}

function pause_spawn_priests()
{
    var p = 
    {
        x: 0,
        y: obj_screensizer.actual_height + 200,
        speed: random_range(0.8, 1.4),
        image_index: 0,
        image_speed: 0.35,
        image_xscale: choose(-1, 1)
    };
    var q = irandom(100);
    
    if (q >= 50)
        p.x = irandom_range(obj_screensizer.actual_width * 0.78, obj_screensizer.actual_width * 0.65);
    else
        p.x = irandom_range(obj_screensizer.actual_width * 0.2, 0.42);
    
    ds_list_add(priest_list, p);
}

function pause_update_priests()
{
    for (var i = 0; i < ds_list_size(priest_list); i++)
    {
        var b = ds_list_find_value(priest_list, i);
        var destroy = false;
        
        with (b)
        {
            y -= speed;
            image_index += image_speed;
            
            if (!other.pause)
                x += ((x > (obj_screensizer.actual_width / 2)) ? 10 : -10);
            
            if (y < -200)
                destroy = true;
        }
        
        if (destroy)
        {
            b = undefined;
            ds_list_delete(priest_list, i--);
        }
    }
}

function pause_draw_priests()
{
    for (var i = 0; i < ds_list_size(priest_list); i++)
    {
        var b = ds_list_find_value(priest_list, i);
        
        with (b)
            draw_sprite_ext(spr_angelpriest, image_index, x, y, image_xscale, 1, 0, c_white, 1);
    }
}
