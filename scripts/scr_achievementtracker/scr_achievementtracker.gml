// TODO because i like pain
// shift all entries values down two
// also fix all notification_push() uses

// also maybe change the names of these
// idk yet tho
enum notifications
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
	john_destroyed = 18,
	brickball_kill = 19,
	pigcitizen_taunt = 20,
	pizzaboy_killed = 21,
	touched_mrpinch = 22,
	priest_touched = 23,
	secret_entered = 24,
	secret_exited = 25,
	destroy_iceblock = 26,
	monster_dead = 27,
	monster_activate = 28,
};

function add_achievement_update(arg0, arg1, arg2, arg3)
{
    var q = 
    {
        name: arg0,
        update_rate: arg1,
        frames: 0,
        update_func: noone,
        creation_code: noone,
        variables: ds_map_create(),
        unlocked: false
    };
    q.update_func = method(q, arg3);
    
    if (arg2 != noone)
    {
        q.creation_code = method(q, arg2);
        q.creation_code();
    }
    
    array_push(obj_achievementtracker.achievements_update, q);
    return q;
}

function add_achievement_notify(arg0, arg1, arg2)
{
    var q = 
    {
        name: arg0,
        creation_code: noone,
        func: noone,
        unlocked: false,
        variables: ds_map_create()
    };
    q.func = method(q, arg2);
    
    if (arg1 != noone)
    {
        q.creation_code = method(q, arg1);
        q.creation_code();
    }
    
    array_push(obj_achievementtracker.achievements_notify, q);
    return q;
}

function notification_push(arg0, arg1)
{
    trace("Pushing notification: ", arg0, " ", arg1);
    
    with (obj_achievementtracker)
        ds_queue_enqueue(notify_queue, [arg0, arg1]);
}

function achievement_add_variable(arg0, arg1, arg2 = false, arg3 = false)
{
    var q = 
    {
        init_value: arg1,
        value: arg1,
        save: arg2,
        resettable: arg3
    };
    ds_map_add(variables, arg0, q);
    return q;
}

function achievement_get_variable(arg0)
{
    return ds_map_find_value(variables, arg0);
}

function achievement_unlock(arg0, arg1, arg2, arg3 = 0)
{
    var b = achievement_get_struct(arg0);
    
    with (b)
    {
        if (!unlocked)
        {
            trace("Achievement unlocked! ", arg0, " ", arg1);
            unlocked = true;
            
            with (instance_create(0, 0, obj_cheftask))
            {
                achievement_spr = arg2;
                achievement_index = arg3;
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

function achievement_reset_variables(arg0)
{
    for (var i = 0; i < array_length(arg0); i++)
    {
        var b = arg0[i];
        
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

function achievement_save_variables(arg0)
{
    for (var i = 0; i < array_length(arg0); i++)
    {
        var b = arg0[i];
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

function achievements_load(arg0)
{
    for (var i = 0; i < array_length(arg0); i++)
    {
        var b = arg0[i];
        
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

function achievement_get_struct(arg0)
{
    var l = obj_achievementtracker.achievements_update;
    var b = noone;
    
    for (var i = 0; i < array_length(l); i++)
    {
        var q = l[i];
        
        if (q.name == arg0)
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
            
            if (q.name == arg0)
            {
                b = q;
                break;
            }
        }
    }
    
    return b;
}
