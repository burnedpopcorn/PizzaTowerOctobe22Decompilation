function secret_add(arg0, arg1)
{
    with (obj_secretmanager)
    {
        ds_list_add(secrettriggers, [arg1]);
        
        if (arg0 != noone)
            method(id, arg0)();
    }
}

function secret_add_touchall(arg0, arg1, arg2)
{
    with (obj_secretmanager)
        ds_list_add(touchall, [arg0, arg1, arg2]);
}

function secret_add_touchall_requirement(arg0, arg1)
{
    touchrequirement[arg0] = [arg1, false];
}

function secret_check_touchall()
{
    if (touchrequirement != noone && is_array(touchrequirement))
    {
        for (var xx = 0; xx < array_length(touchrequirement); xx++)
        {
            var t = bg_chateauscrolldeco;
            
            for (var i = 0; i < ds_list_size(touchall); i++)
            {
                b = touchall[| i];
                
                if (b[1] == xx)
                    t += spr_plug;
            }
            
            if (t == touchrequirement[xx][0])
                touchrequirement[xx][1] = true;
        }
        
        var b = true;
        
        for (var i = 0; i < array_length(touchrequirement); i++)
        {
            if (!touchrequirement[i][1])
            {
                b = false;
                break;
            }
        }
        
        if (b)
            return true;
    }
    
    return false;
}

function secret_check_trigger(arg0)
{
    var _found = false;
    
    with (obj_secrettrigger)
    {
        if (trigger == arg0 && active)
            _found = true;
    }
    
    if (_found)
    {
        trace(
        {
            found: _found
        });
    }
    
    return _found;
}

function secret_open_portal(arg0)
{
    with (obj_secretportal)
    {
        if (trigger == arg0 && ds_list_find_index(global.saveroom, id) == -1 && !place_meeting(x, y, obj_marbleblock) && !place_meeting(x, y, obj_secretblock) && !place_meeting(x, y, obj_secretbigblock) && !place_meeting(x, y, obj_secretmetalblock) && !place_meeting(x, y, obj_secretdestroyable))
            active = true;
    }
}

function secret_close_portal(arg0, arg1 = false)
{
    with (obj_secretportal)
    {
        if (trigger == arg0 && sprite_index != spr_secretportal_close)
        {
            sprite_index = spr_secretportal_close;
            
            if (!arg1)
                image_index = 0;
            else
                image_index = 14;
            
            active = false;
        }
    }
}

function secret_close_portalID(arg0)
{
    with (arg0)
    {
        sprite_index = spr_secretportal_close;
        image_index = 14;
        active = false;
    }
}
