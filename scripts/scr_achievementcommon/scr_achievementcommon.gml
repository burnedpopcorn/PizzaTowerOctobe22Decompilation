function add_secrets_achievement(arg0, arg1)
{
    var b = add_achievement_notify(concat("secrets", arg0), -4, function(arg0)
    {
        var type = arg0[0];
        var arr = arg0[1];
        
        if (type == UnknownEnum.Value_3)
        {
            var n = levelarray;
            var _unfinished = false;
            ini_open_from_string(obj_savesystem.ini_str);
            
            for (var i = 0; i < array_length(n); i++)
            {
                var b = n[i];
                var s = ini_read_real("Secret", b, 0);
                
                if (s < 3)
                    _unfinished = true;
            }
            
            ini_close();
            
            if (!_unfinished)
                achievement_unlock(name, -4, spr_achievement_farm, 0);
        }
    });
    b.levelarray = arg1;
    
    with (b)
        var n = arg1;
}

function scr_custom_notification_destructibles()
{
    active = false;
    
    step = function()
    {
        if (!active)
        {
            if (!place_meeting(x, y, obj_destructibles))
            {
                active = true;
                notification_push(notifications.treasureguy_uncovered, [room]);
            }
        }
    };
}
