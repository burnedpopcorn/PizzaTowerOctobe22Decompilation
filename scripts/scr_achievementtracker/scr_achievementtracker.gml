// notifications
enum notifs
{
	generic_killed = 0,
	room_enemiesdead = 1,
	enemy_parried = 2,
	level_finished = 3,
	mortcube_destroyed = 4,
	hurt_player = 5,
	fell_into_pit = 6,
	beer_knocked = 7,
	touched_timedgate = 8,
	flush_done = 9,
	baddie_killed_projectile = 10,
	treasureguy_uncovered = 11,
	special_destroyable_destroyed = 12,
	custom_destructibles_destroyed = 13,
	pizzaball_shot = 14,
	pizzaball_kill = 15,
	pizzaball_goal = 16,
	brickball_start = 17,
	brickball_kill = 18,
	pigcitizen_taunt = 19,
	pizzaboy_killed = 20,
	touched_mrpinch = 21,
	priest_touched = 22,
	secret_entered = 23,
	secret_exited = 24,
	destroy_iceblock = 25,
	monster_dead = 26,
	monster_activate = 27,
	monster_jumpscare = 28,
};

function add_achievement_update(_name, _update_rate, _cc_func, _update_func)
{
    var q = 
    {
        name: _name,
        update_rate: _update_rate,
        frames: 0,
        update_func: noone,
        creation_code: noone,
        variables: ds_map_create(),
        unlocked: false
    };
    q.update_func = method(q, _update_func);
    
    if (_cc_func != noone)
    {
        q.creation_code = method(q, _cc_func);
        q.creation_code();
    }
    
    array_push(obj_achievementtracker.achievements_update, q);
    return q;
}

function add_achievement_notify(_name, _cc_func, _func)
{
    var q = 
    {
        name: _name,
        creation_code: noone,
        func: noone,
        unlocked: false,
        variables: ds_map_create()
    };
    q.func = method(q, _func);
    
    if (_cc_func != noone)
    {
        q.creation_code = method(q, _cc_func);
        q.creation_code();
    }
    
    array_push(obj_achievementtracker.achievements_notify, q);
    return q;
}

function notification_push(_notif, _array)
{
    trace("Pushing notification: ", _notif, " ", _array);
    
    with (obj_achievementtracker)
        ds_queue_enqueue(notify_queue, [_notif, _array]);
}

function achievement_add_variable(_name, _value, _save = false, _resettable = false)
{
    var q = 
    {
        init_value: _value,
        value: _value,
        save: _save,
        resettable: _resettable
    };
    ds_map_add(variables, _name, q);
    return q;
}

function achievement_get_variable(_name)
{
    return ds_map_find_value(variables, _name);
}

function achievement_unlock(_name, _disp_name, _sprite, _index = 0)
{
    var b = achievement_get_struct(_name);
    
    with (b)
    {
        if (!unlocked)
        {
            trace("Achievement unlocked! ", _name, " ", _disp_name);
            unlocked = true;
            
            with (instance_create(0, 0, obj_cheftask))
            {
                achievement_spr = _sprite;
                achievement_index = _index;
            }
            
            ini_open_from_string(obj_savesystem.ini_str);
            ini_write_real("achievements", name, true);
            obj_savesystem.ini_str = ini_close();
            gamesave_async_save();
            
            with (obj_player1)
            {
                repeat (10)
                    instance_create(x, y, obj_confettieffect);
            }
        }
    }
    
    with (obj_achievementviewer)
        event_perform(ev_other, ev_room_start);
}

function achievement_reset_variables(_array)
{
    for (var i = 0; i < array_length(_array); i++)
    {
        var b = _array[i];
        
        with (b)
        {
            var size = ds_map_size(variables);
            var key = ds_map_find_first(variables);
            
            for (var j = 0; j < size; j++)
            {
                var q = ds_map_find_value(variables, key);
                
                if (q.resettable)
                    q.value = q.init_value;
                
                key = ds_map_find_next(variables, key);
            }
        }
    }
}

function achievement_save_variables(_array)
{
    for (var i = 0; i < array_length(_array); i++)
    {
        var b = _array[i];
        ini_open_from_string(obj_savesystem.ini_str);
        
        with (b)
        {
            var size = ds_map_size(variables);
            var key = ds_map_find_first(variables);
            
            for (var j = 0; j < size; j++)
            {
                var q = ds_map_find_value(variables, key);
                
                if (q.save)
                    ini_write_real("achievements_variables", key, q.value);
                
                key = ds_map_find_next(variables, key);
            }
        }
        
        obj_savesystem.ini_str = ini_close();
    }
}

function achievements_load(_array)
{
    for (var i = 0; i < array_length(_array); i++)
    {
        var b = _array[i];
        
        with (b)
        {
            unlocked = ini_read_real("achievements", name, false);
            var size = ds_map_size(variables);
            var key = ds_map_find_first(variables);
            
            for (var j = 0; j < size; j++)
            {
                var q = ds_map_find_value(variables, key);
                
                if (q.save)
                    q.value = ini_read_real("achievements_variables", key, q.init_value);
                
                key = ds_map_find_next(variables, key);
            }
        }
    }
}

function achievement_get_struct(_name)
{
    var l = obj_achievementtracker.achievements_update;
    var b = noone;
    
    for (var i = 0; i < array_length(l); i++)
    {
        var q = l[i];
        
        if (q.name == _name)
        {
            b = q;
            break;
        }
    }
    
    if (b == noone)
    {
        l = obj_achievementtracker.achievements_notify;
        
        for (var i = 0; i < array_length(l); i++)
        {
            var q = l[i];
            
            if (q.name == _name)
            {
                b = q;
                break;
            }
        }
    }
    
    return b;
}
