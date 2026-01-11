function secret_add(_create_func, _func)
{
    with (obj_secretmanager)
    {
        ds_list_add(secrettriggers, [_func]);
        
        if (_create_func != noone)
            method(id, _create_func)();
    }
}

function secret_add_touchall(_room, _trigger, _touchallID)
{
    with (obj_secretmanager)
        ds_list_add(touchall, [_room, _trigger, _touchallID]);
}

function secret_add_touchall_requirement(_idx, _trigger)
{
    touchrequirement[_idx] = [_trigger, false];
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

function secret_check_trigger(_secret_trigger)
{
    var _found = false;
    
    with (obj_secrettrigger)
    {
        if (trigger == _secret_trigger && active)
            _found = true;
    }
    
    if (_found)
        trace( { found: _found } );
    
    return _found;
}

function secret_open_portal(_secret_trigger)
{
    with (obj_secretportal)
    {
        if (trigger == _secret_trigger && ds_list_find_index(global.saveroom, id) == -1 && !place_meeting(x, y, obj_marbleblock) && !place_meeting(x, y, obj_secretblock) && !place_meeting(x, y, obj_secretbigblock) && !place_meeting(x, y, obj_secretmetalblock) && !place_meeting(x, y, obj_secretdestroyable))
            active = true;
    }
}

function secret_close_portal(_secret_trigger, _fast = false)
{
    with (obj_secretportal)
    {
        if (trigger == _secret_trigger && sprite_index != spr_secretportal_close)
        {
            sprite_index = spr_secretportal_close;
            
            if (!_fast)
                image_index = 0;
            else
                image_index = 14;
            
            active = false;
        }
    }
}

function secret_close_portalID(_portalID)
{
    with (_portalID)
    {
        sprite_index = spr_secretportal_close;
        image_index = 14;
        active = false;
    }
}
