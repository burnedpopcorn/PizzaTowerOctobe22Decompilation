function create_afterimage(arg0, arg1, arg2, arg3)
{
    var q = 
    {
        x: arg0,
        y: arg1,
        sprite_index: arg2,
        image_index: arg3,
        image_angle: 0,
        alarm: [15, 6, -1],
        image_blend: choose(global.afterimage_color1, global.afterimage_color2),
        image_xscale: 1,
        image_yscale: 1,
        identifier: afterimagetype.normal,
        visible: true,
        alpha: 1
    };
    ds_list_add(global.afterimage_list, q);
    return q;
}

function create_mach3effect(arg0, arg1, arg2, arg3)
{
    var q = 
    {
        x: arg0,
        y: arg1,
        sprite_index: arg2,
        image_index: arg3,
        image_angle: 0,
        alarm: [15, 6, -1],
        image_blend: choose(global.mach_color1, global.mach_color2),
        image_xscale: 1,
        image_yscale: 1,
        visible: true,
        identifier: afterimagetype.mach3effect,
        playerid: obj_player1,
        alpha: 1
    };
    ds_list_add(global.afterimage_list, q);
    return q;
}

function create_heatattack_afterimage(arg0, arg1, arg2, arg3, arg4)
{
    var _velocity = 6;
    
    with (create_afterimage(arg0, arg1, arg2, arg3))
    {
        identifier = afterimagetype.heatattack;
        alarm[1] = -1;
        alarm[2] = -1;
        alarm[0] = 8;
        image_xscale = arg4;
        hsp = _velocity;
        vsp = 0;
        image_blend = global.afterimage_color1;
    }
    
    with (create_afterimage(arg0, arg1, arg2, arg3))
    {
        identifier = afterimagetype.heatattack;
        alarm[1] = -1;
        alarm[2] = -1;
        alarm[0] = 8;
        image_xscale = arg4;
        hsp = -_velocity;
        vsp = 0;
        image_blend = global.afterimage_color1;
    }
    
    with (create_afterimage(arg0, arg1, arg2, arg3))
    {
        identifier = afterimagetype.heatattack;
        alarm[1] = -1;
        alarm[2] = -1;
        alarm[0] = 8;
        image_xscale = arg4;
        hsp = 0;
        vsp = _velocity;
        image_blend = global.afterimage_color1;
    }
    
    with (create_afterimage(arg0, arg1, arg2, arg3))
    {
        identifier = afterimagetype.heatattack;
        alarm[1] = -1;
        alarm[2] = -1;
        alarm[0] = 8;
        image_xscale = arg4;
        hsp = 0;
        vsp = -_velocity;
        image_blend = global.afterimage_color1;
    }
}

function create_firemouth_afterimage(arg0, arg1, arg2, arg3, arg4)
{
    var b = create_afterimage(arg0, arg1, arg2, arg3);
    
    with (b)
    {
        fadeout = false;
        fadeoutstate = noone;
        identifier = afterimagetype.firemouth;
        alarm[0] = -1;
        alarm[1] = -1;
        alarm[2] = -1;
        image_xscale = arg4;
        image_blend = make_color_rgb(248, 112, 24);
        alpha = 0.8;
        basealpha = 1;
        playerid = noone;
        vertical = false;
        maxmovespeed = 10;
    }
    
    return b;
}

function create_blue_afterimage(arg0, arg1, arg2, arg3, arg4)
{
    var b = create_afterimage(arg0, arg1, arg2, arg3);
    
    with (b)
    {
        fadeout = false;
        fadeoutstate = noone;
        identifier = afterimagetype.blue;
        alarm[0] = -1;
        alarm[1] = -1;
        alarm[2] = -1;
        image_xscale = arg4;
        image_blend = make_color_rgb(44, 126, 228);
        alpha = 0.8;
        basealpha = 1;
        playerid = noone;
        vertical = false;
        maxmovespeed = 10;
    }
    
    return b;
}

function create_red_afterimage(arg0, arg1, arg2, arg3, arg4)
{
    var b = create_blue_afterimage(arg0, arg1, arg2, arg3, arg4);
    
    with (b)
        identifier = afterimagetype.red;
    
    return b;
}

function create_blur_afterimage(arg0, arg1, arg2, arg3, arg4)
{
    var b = create_afterimage(arg0, arg1, arg2, arg3);
    
    with (b)
    {
        fadeout = false;
        fadeoutstate = noone;
        identifier = afterimagetype.blur;
        alarm[0] = -1;
        alarm[1] = -1;
        alarm[2] = -1;
        image_blend = c_white;
        image_xscale = arg4;
        alpha = 0.8;
        playerid = noone;
        spd = 0.15;
        hsp = 0;
        vsp = 0;
    }
    
    return b;
}
