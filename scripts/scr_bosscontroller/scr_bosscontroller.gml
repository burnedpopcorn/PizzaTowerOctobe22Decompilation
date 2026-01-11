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
                var btx = SCREEN_WIDTH;
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

function scr_bosscontroller_draw_health(_sprite, _maxrows, _maxcolumn, _HPcurrent, _HPmax, _HPx, _HPy, _xpad, _ypad, _subimg_index, _palette = noone)
{
    var hpp = 0;
    
    for (var _index = 0; hpp < _HPmax; _index++)
    {
        var c = c_white;
        var zpad = _index * 3;
        
        if (_palette != noone)
            pal_swap_set(_palette, _index, false);
        
        var _x = 0;
        var _y = 0;
        
        repeat (_maxrows * _maxcolumn)
        {
            if (_index == 0 && _HPcurrent < (_maxrows * _maxcolumn) && hpp >= _HPcurrent)
                c = 0;
            
            if (_index == 0 || hpp < _HPcurrent)
                draw_sprite_ext(_sprite, _subimg_index, (_HPx + (_x * _xpad)) - zpad, (_HPy + (_y * _ypad)) - zpad, 1, 1, 0, c, 1);
            
            _x++;
            
            if (_x >= _maxcolumn)
            {
                _x = 0;
                _y++;
            }
            
            hpp++;
        }
    }
}

function scr_bosscontroller_get_health_pos(_HPcurrent, _maxrow, _maxcolumn, _HPmax, _HPx, _HPy, _xpad, _ypad, _unused = false)
{
    var hpp = 0;
    
    for (var _index = 0; hpp < _HPmax; _index++)
    {
        var zpad = _index * 3;
        var _x = 0;
        var _y = 0;
        
        repeat (_maxrow * _maxcolumn)
        {
            hpp++;
            
            if (hpp >= _HPcurrent)
                return [(_HPx + (_x * _xpad)) - zpad, (_HPy + (_y * _ypad)) - zpad, _index];
            
            _x++;
            
            if (_x >= _maxcolumn)
            {
                _x = 0;
                _y++;
            }
        }
    }
    
    return undefined;
}
