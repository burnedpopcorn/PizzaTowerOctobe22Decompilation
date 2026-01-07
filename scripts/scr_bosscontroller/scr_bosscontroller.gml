function scr_bosscontroller_intro()
{
    with (obj_player)
    {
        state = states.actor;
        image_blend = make_colour_hsv(0, 0, 255);
        hsp = 0;
    }
    
    with (bossID)
    {
        if (state != states.actor)
            other.bossintrostate = state;
        
        state = states.actor;
        x = xstart;
        y = ystart;
        hsp = 0;
        vsp = 0;
    }
    
    flamey -= 4;
    
    if (introshake > 0)
        introshake -= introshake_acc;
    
    var a = 0.1;
    
    if (arenabuffer > 0)
        arenabuffer--;
    else
    {
        switch (arenastate)
        {
            case 0:
                var ptx = 0;
                playerx = lerp(playerx, ptx, a);
                
                if (abs(playerx - ptx) <= 10)
                    arenastate++;
                
                break;
            
            case 1:
                var btx = obj_screensizer.actual_width;
                bossx = lerp(bossx, btx, a);
                
                if (abs(bossx - btx) <= 10)
                    arenastate++;
                
                break;
            
            case 2:
                whitefade += 0.02;
                
                if (whitefade >= 2)
                {
                    whitefade = 0;
                    arenastate++;
                    arenabuffer = 300;
                    introshake = 20;
                    introshake_acc = 0.5;
                }
                
                break;
            
            case 3:
                state = states.normal;
                
                with (obj_player)
                    state = states.normal;
                
                with (bossID)
                    state = other.bossintrostate;
                
                break;
        }
    }
}

function scr_bosscontroller_normal()
{
    if (boss_func != noone)
        boss_func();
    
    if (boss_prevhp != boss_hp)
    {
        if (boss_prevhp > 0)
        {
            var pos = scr_bosscontroller_get_health_pos(boss_hp + 1, boss_rowmax, boss_columnmax, boss_maxhp, boss_hp_x, boss_hp_y, boss_xpad, boss_ypad, true);
            
            if (!is_undefined(pos) && is_array(pos))
            {
                with (instance_create(pos[0], pos[1], obj_sausageman_dead))
                {
                    usepalette = true;
                    sprite_index = other.boss_hpsprite;
                    spr_palette = other.boss_palette;
                    paletteselect = pos[2];
                    image_index = irandom(sprite_get_number(sprite_index) - 1);
                    hsp = -8;
                    vsp = -6;
                }
            }
        }
        
        boss_prevhp = boss_hp;
    }
    
    if (!instance_exists(bossID) && !bossdead && obj_player1.state != states.tackle && room != boss_fakepephallway && room != boss_pizzaface)
    {
        if (room != boss_vigilante || obj_player1.state != states.actor)
        {
            bossdead = true;
            alarm[0] = 150;
            
            with (obj_player1)
            {
                sprite_index = spr_player_levelcomplete;
                image_speed = 0.35;
                image_index = 0;
                state = states.arenaintro;
            }
        }
    }
    
    if (!bossdead && player_hp <= 0)
    {
        player_hp = 0;
        
        with (obj_player1)
        {
            global.pistol = false;
            targetDoor = "HUB";
            room = backtohubroom;
            x = backtohubstartx;
            y = backtohubstarty;
        }
    }
}

function scr_bosscontroller_victory()
{
    if (victory_buffer > 0)
        victory_buffer--;
    else if (!instance_exists(obj_bosskeynoise))
    {
        if (player_hp > 0)
        {
            victory_buffer = 25;
            var pos = scr_bosscontroller_get_health_pos(player_hp, player_rowmax, player_columnmax, player_maxhp, player_hp_x, player_hp_y, player_xpad, player_ypad);
            player_hp--;
            
            with (instance_create(pos[0], pos[1], obj_hpeffect))
            {
                x_to = obj_player1.x;
                y_to = obj_player1.y;
                spd = 16;
                finish = true;
            }
        }
        else if (!instance_exists(obj_hpeffect) && !instance_exists(obj_endlevelfade))
            scr_do_rank();
    }
}

function scr_bosscontroller_draw_health(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10 = -4)
{
    var hpp = 0;
    
    for (var _index = 0; hpp < arg4; _index++)
    {
        var c = c_white;
        var zpad = _index * 3;
        
        if (arg10 != -4)
            pal_swap_set(arg10, _index, false);
        
        var _x = 0;
        var _y = 0;
        
        repeat (arg1 * arg2)
        {
            if (_index == 0 && arg3 < (arg1 * arg2) && hpp >= arg3)
                c = 0;
            
            if (_index == 0 || hpp < arg3)
                draw_sprite_ext(arg0, arg9, (arg5 + (_x * arg7)) - zpad, (arg6 + (_y * arg8)) - zpad, 1, 1, 0, c, 1);
            
            _x++;
            
            if (_x >= arg2)
            {
                _x = 0;
                _y++;
            }
            
            hpp++;
        }
    }
}

function scr_bosscontroller_get_health_pos(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 = false)
{
    var hpp = 0;
    
    for (var _index = 0; hpp < arg3; _index++)
    {
        var zpad = _index * 3;
        var _x = 0;
        var _y = 0;
        
        repeat (arg1 * arg2)
        {
            hpp++;
            
            if (hpp >= arg0)
                return [(arg4 + (_x * arg6)) - zpad, (arg5 + (_y * arg7)) - zpad, _index];
            
            _x++;
            
            if (_x >= arg2)
            {
                _x = 0;
                _y++;
            }
        }
    }
    
    return undefined;
}
