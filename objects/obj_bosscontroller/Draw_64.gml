if (instance_exists(obj_pizzafaceboss_p3intro))
    exit;

switch (state)
{
    case states.arenaintro:
        if (arenastate < 3)
        {
            draw_set_alpha(1);
            draw_rectangle_color(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, c_white, c_white, c_white, c_white, false);
            draw_sprite_ext(playerspr, -1, playerx, SCREEN_HEIGHT, 1, 1, 0, c_black, 1);
            draw_sprite_ext(bossspr, -1, bossx, SCREEN_HEIGHT, 1, 1, 0, c_black, 1);
            draw_set_alpha(whitefade);
            draw_rectangle_color(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, c_white, c_white, c_white, c_white, false);
            draw_set_alpha(1);
        }
        else
        {
            draw_sprite_tiled(spr_versusflame, -1, 0, flamey);
            var c_player = c_white;
            var sx = irandom_range(-introshake, introshake);
            var sy = irandom_range(-introshake, introshake);
            var _index = 0;
            var _xs = 1;
            var _ys = 1;
            
            if (bossspr == 3147)
            {
                if (glitchbuffer > 0)
                {
                    glitchbuffer--;
                }
                else
                {
                    glitchbuffer = 80;
                    _index = 1;
                    _xs = random_range(0.5, 2);
                    _ys = random_range(0.5, 2);
                }
            }
            
            var px = playerx + sx;
            var py = SCREEN_HEIGHT + sy;
            var bx = bossx + sy;
            var by = SCREEN_HEIGHT + sy;
            
            if (px > 0)
                px = 0;
            
            if (py < SCREEN_HEIGHT)
                py = SCREEN_HEIGHT;
            
            if (bx < SCREEN_WIDTH)
                bx = SCREEN_WIDTH;
            
            if (by < SCREEN_HEIGHT)
                by = SCREEN_HEIGHT;
            
            draw_sprite_ext(playerspr, -1, px, py, 1, 1, 0, c_player, 1);
            draw_sprite_ext(bossspr, _index, bx, by, _xs, _ys, 0, c_player, 1);
            var xx = irandom_range(-1, 1) + sx;
            var yy = irandom_range(-1, 1) + sy;
            draw_sprite(vstitle, -1, xx, yy);
        }
        
        break;
    
    case states.normal:
    case states.victory:
        scr_bosscontroller_draw_health(spr_bossfight_playerhp, player_rowmax, player_columnmax, player_hp, player_maxhp, player_hp_x, player_hp_y, player_xpad, player_ypad, player_index, noone);
        shader_set(global.Pal_Shader);
        scr_bosscontroller_draw_health(boss_hpsprite, boss_rowmax, boss_columnmax, boss_hp, boss_maxhp, boss_hp_x, boss_hp_y, boss_xpad, boss_ypad, boss_index, boss_palette);
        reset_shader_fix();
        break;
}
