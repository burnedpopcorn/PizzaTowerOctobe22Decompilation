function scr_monster_activate()
{
    notification_push(notifs.monster_activate, [room, object_index]);
    
    with (obj_monster)
    {
        if (state == states.robotidle)
            state = states.robotintro;
    }
    
    with (obj_monstergate)
    {
        if (!active)
        {
            active = true;
            instance_deactivate_object(solidID);
            image_speed = 0.35;
        }
    }
    
    instance_create_unique(0, 0, obj_kidspartybg);
}

function get_triangle_points(arg0, arg1, arg2, arg3, arg4)
{
    var x2 = arg0 + lengthdir_x(arg3, arg2 - arg4);
    var y2 = arg1 + lengthdir_y(arg3, arg2 - arg4);
    var x3 = arg0 + lengthdir_x(arg3, arg2 + arg4);
    var y3 = arg1 + lengthdir_y(arg3, arg2 + arg4);
    return [x2, y2, x3, y3];
}

function scr_monster_detect(arg0, arg1, arg2)
{
    var _dir = (image_xscale > 0) ? (arg2.x > x) : (arg2.x < x);
    
    if (_dir && arg2.x < (x + arg0) && arg2.x > (x - arg0) && arg2.y < (y + arg1) && arg2.y > (y - arg1))
    {
        var detect = false;
        
        if (arg2.y > (y - 200))
        {
            with (arg2)
            {
                if (state != states.crouch || (!scr_solid(x, y - 24) && !place_meeting(x, y - 24, obj_platform)))
                    detect = true;
            }
        }
        
        if (detect)
            return true;
    }
    
    return false;
}

function scr_puppet_detect()
{
    with (obj_player)
    {
        if ((object_index != obj_player2 || global.coop) && !place_meeting(x, y, obj_puppetsafezone))
            return id;
    }
    
    return noone;
}

function scr_puppet_appear(arg0)
{
    var _xdir = 96;
    var i = 0;
    
    while (collision_line(arg0.x, arg0.y, arg0.x + (_xdir * arg0.xscale), arg0.y, obj_solid, false, true))
    {
        _xdir--;
        i++;
        
        if (i > room_width)
        {
            x = arg0.x;
            break;
        }
    }
    
    x = arg0.x + (abs(_xdir) * arg0.xscale);
    y = arg0.y;
    state = states.robotchase;
    substate = states.fall;
    playerid = arg0;
    
    while (place_meeting(x, y, obj_solid))
    {
        x += ((arg0.x > x) ? 1 : -1);
        i++;
        
        if (i > room_width)
        {
            x = arg0.x;
            break;
        }
    }
    
    var _col = collision_line(x, y, x, y - room_height, obj_solid, true, false);
    
    if (_col != noone)
    {
        while (!place_meeting(x, y - 1, obj_solid))
            y--;
    }
}

function scr_monsterinvestigate(arg0, arg1, arg2)
{
    targetplayer = instance_nearest(x, y, obj_player);
    image_speed = 0.35;
    
    switch (investigatestate)
    {
        case 0:
        case 1:
            sprite_index = arg1;
            hsp = image_xscale * arg0;
            
            if (place_meeting(x + sign(hsp), y, obj_monstersolid) && (!place_meeting(x + sign(hsp), y, obj_monsterslope) || place_meeting(x + sign(hsp), y - 4, obj_solid)))
            {
                investigatestate++;
                image_xscale *= -1;
            }
            
            if (investigatestate == 1)
            {
                if ((image_xscale > 0 && x > (room_width / 2)) || (image_xscale < 0 && x < (room_width / 2)))
                {
                    investigatestate = 2;
                    waitbuffer = 100;
                }
            }
            
            break;
        
        case 2:
            sprite_index = arg2;
            hsp = 0;
            
            if (waitbuffer > 0)
            {
                waitbuffer--;
            }
            else
            {
                state = states.robotroaming;
                image_xscale *= -1;
                instance_create(x, y, obj_patroller);
            }
            
            break;
    }
    
    if (scr_monster_detect(300, room_height, targetplayer))
        state = states.robotchase;
}

function scr_monster_detect_audio()
{
    if (scr_monster_audio_check())
    {
        if (!point_in_camera(x, y, view_camera[0]))
        {
            state = states.robotinvestigate;
            investigatestate = 0;
        }
        else
        {
            targetplayer = instance_nearest(x, y, obj_player);
            
            if (object_index == obj_blobmonster)
            {
                state = states.fall;
                gravdir *= -1;
                chase = false;
            }
            else
            {
                state = states.robotchase;
            }
        }
    }
}

function scr_monster_audio_check()
{
    if (audio_is_playing(sfx_groundpound) || audio_is_playing(sfx_scream5))
        return true;
    
    return false;
}
