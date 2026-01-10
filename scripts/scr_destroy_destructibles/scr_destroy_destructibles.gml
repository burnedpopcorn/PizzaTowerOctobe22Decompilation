function scr_destroy_destructibles(arg0, arg1)
{
    if (!place_meeting(x + arg0, y + arg1, obj_destructibles))
        exit;
    
    var _num = instance_place_list(x + arg0, y + arg1, obj_destructibles, global.instancelist, false);
    
    if (_num > 0)
    {
        for (var i = 0; i < ds_list_size(global.instancelist); i++)
            instance_destroy(global.instancelist[| i]);
        
        ds_list_clear(global.instancelist);
    }
}
