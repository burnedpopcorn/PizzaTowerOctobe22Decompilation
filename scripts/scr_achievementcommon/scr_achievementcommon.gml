function add_secrets_achievement(_secret, _levelarray)
{
    var b = add_achievement_notify(concat("secrets", _secret), noone, function(_data)
    {
        var type = _data[0];
        var arr = _data[1];
        
        if (type == notifs.level_finished)
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
                achievement_unlock(name, noone, spr_achievement_farm, 0);
        }
    });
    b.levelarray = _levelarray;
    
	// seems to be useless code...
    with (b)
        var n = _levelarray;
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
                notification_push(notifs.custom_destructibles_destroyed, [room]);
            }
        }
    };
}
