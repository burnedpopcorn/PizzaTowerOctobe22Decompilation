function get_dark(_blend, _use_dark)
{
    if (_use_dark)
    {
        var d = room_width * room_height;
        var b = d;
        var bb = b;
        
        with (obj_lightsource)
        {
            if (object_index != obj_lightsource_attach || instance_exists(objectID))
            {
                var dis = distance_to_object(other);
                
                if (distance_to_object(other) < d)
                {
                    bb = dis / distance;
                    
                    if (bb < b)
                    {
                        b = bb;
                        d = dis;
                    }
                }
            }
        }
        
        var t = (b + 0.4) * spr_robot_knife;
        var a = (1 - obj_drawcontroller.dark_alpha) * 255;
        a -= 102;
        t = clamp(t, 0, 255);
        a = clamp(a, 0, 255);
        return make_color_rgb((color_get_red(_blend) - t) + a, (color_get_green(_blend) - t) + a, (color_get_blue(_blend) - t) + a);
    }
    else
        return image_blend;
}

function draw_enemy(_healthbar, _palette, _color = c_white)
{
    var _stun = 0;
    
    if (state == states.stun && thrown == false && object_index != obj_peppinoclone)
        _stun = 25;
    
    if (visible && object_index != obj_pizzaball && object_index != obj_fakesanta && bbox_in_camera(view_camera[0], 32))
    {
        var c = image_blend;
        
        if (elite)
            c = c_yellow;
        
        if (elitegrab)
            c = c_green;
        
        if (_color != c_white)
            c = _color;
        
        var b = get_dark(c, obj_drawcontroller.use_dark);
        
        if (object_index == obj_peppinoclone)
        {
            shader_set(global.Pal_Shader);
            pal_swap_set(spr_peppalette, 1, false);
        }
        else if (usepalette && _palette)
        {
            shader_set(global.Pal_Shader);
            pal_swap_set(spr_palette, paletteselect, false);
        }
        
        var _ys = 1;
        
        if (state == states.grabbed)
        {
            var g = (grabbedby == 1) ? obj_player1.id : obj_player2.id;
            
            if (g.state == states.superslam)
            {
                _stun += 18;
                _ys = -1;
            }
        }
        
        draw_sprite_ext(sprite_index, image_index, x, y + _stun, xscale * image_xscale, yscale * _ys, angle, b, image_alpha);
        
        if (_healthbar)
        {
            if (hp > maxhp)
                maxhp = hp;
            
            draw_healthbar(x - 16, y - 50, x + 16, y - 45, (hp / maxhp) * 100, c_black, c_red, c_red, 0, true, true);
        }
        
        if (object_index == obj_peppinoclone || (usepalette && _palette))
            shader_reset();
        
        if (object_index == obj_hamkuff)
        {
            if (state == states.blockstance && instance_exists(playerid))
            {
                var x1 = x + (6 * image_xscale);
                var y1 = y + 29;
                
                if (sprite_index == spr_hamkuff_chain2)
                {
                    x1 = x + (15 * image_xscale);
                    y1 = y + 33;
                }
                
                var dis = point_distance(x1, y1, playerid.x, playerid.y);
                var w = 24;
                var len = dis div w;
                var dir = point_direction(x1, y1, playerid.x, playerid.y + 16);
                var xx = lengthdir_x(w, dir);
                var yy = lengthdir_y(w, dir);
                
                for (var i = 0; i < len; i++)
                    draw_sprite_ext(spr_hamkuff_sausage, -1, x1 + (xx * i), y1 + (yy * i), 1, 1, dir, b, 1);
            }
        }
    }
}

function draw_superslam_enemy()
{
    if (state == states.superslam && floor(image_index) >= 5 && floor(image_index) <= 7 && instance_exists(baddiegrabbedID))
    {
        with (baddiegrabbedID)
            draw_enemy(global.kungfu, true);
    }
}

function draw_player()
{
    var ps = paletteselect;
    
    if (global.noisejetpack)
        ps = 2;
    
    pal_swap_set(spr_palette, ps, false);
    var b = get_dark(image_blend, other.use_dark);
    draw_sprite_ext(sprite_index, image_index, x, y, xscale * scale_xs, yscale * scale_ys, angle, b, image_alpha);
    draw_superslam_enemy();
}
