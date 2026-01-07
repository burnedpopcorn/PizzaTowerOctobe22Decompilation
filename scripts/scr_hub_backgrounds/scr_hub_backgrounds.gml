function scr_hub_bg_init(arg0 = 1)
{
    bgsprite = spr_gate_entranceBG;
    bgsprite_number = sprite_get_number(bgsprite);
    bgsprite_width = sprite_get_width(bgsprite);
    bgsprite_height = sprite_get_height(bgsprite);
    bgspritepos = 0;
    bgspriteposstart = 0;
    bgalpha = 1;
    bg_useparallax = false;
    bgparallax = [0.65 * arg0, 0.75 * arg0, 0.85 * arg0];
    bgparallax2 = [0.1 * arg0, 0.15 * arg0, 0.2 * arg0];
    bgmask_surface = noone;
    bgclip_surface = noone;
}

function scr_hub_bg_reinit(arg0, arg1)
{
    bgsprite_number = sprite_get_number(bgsprite);
    bgsprite_width = sprite_get_width(bgsprite);
    bgsprite_height = sprite_get_height(bgsprite);
    
    for (var i = 0; i < bgsprite_number; i++)
    {
        bgspritepos[i] = 0;
        
        if (bg_useparallax)
        {
            var p = bgparallax2[i];
            bgspriteposstart[i] = [arg0 - (arg0 * p) - ((obj_screensizer.actual_width / 4) * p), arg1 - (arg1 * p) - ((obj_screensizer.actual_height / 4) * p)];
            bgspritepos[i] = [bgspriteposstart[i][0], bgspriteposstart[i][1]];
        }
    }
}

function scr_hub_bg_step()
{
    for (var i = 0; i < array_length(bgspritepos); i++)
    {
        if (!bg_useparallax)
        {
            bgspritepos[i] -= bgparallax[i];
            
            if (bgspritepos[i] <= -(bgsprite_width + bgparallax[i]))
                bgspritepos[i] = frac(bgspritepos[i]);
        }
        else
        {
            var p = bgparallax2[i];
            bgspritepos[i][0] = bgspriteposstart[i][0] + (camera_get_view_x(view_camera[0]) * p);
            bgspritepos[i][1] = bgspriteposstart[i][1] + (camera_get_view_y(view_camera[0]) * p);
        }
    }
}

function scr_hub_bg_draw(arg0, arg1, arg2, arg3, arg4 = false)
{
    if (bgalpha < 1)
    {
        var w = sprite_get_width(arg2);
        var h = sprite_get_height(arg2);
        var x1 = sprite_get_xoffset(arg2);
        var y1 = sprite_get_yoffset(arg2);
        
        if (!surface_exists(bgmask_surface))
        {
            bgmask_surface = surface_create(w, h);
            surface_set_target(bgmask_surface);
            draw_clear(c_black);
            gpu_set_blendmode(bm_subtract);
            draw_sprite(arg2, arg3, x1, y1);
            
            if (!arg4)
                gpu_set_blendmode(bm_normal);
            else
                reset_blendmode();
            
            surface_reset_target();
        }
        
        if (!surface_exists(bgclip_surface))
            bgclip_surface = surface_create(w, h);
        
        surface_set_target(bgclip_surface);
        draw_clear_alpha(c_black, 0);
        
        for (var i = 0; i < array_length(bgspritepos); i++)
        {
            if (!bg_useparallax)
            {
                var b = bgspritepos[i];
                draw_sprite_tiled(bgsprite, i, b, h);
            }
            else
            {
                var bx = bgspritepos[i][0];
                var by = bgspritepos[i][1];
                draw_sprite_tiled(bgsprite, i, bx - arg0, (by + h) - arg1);
            }
        }
        
        gpu_set_blendmode(bm_subtract);
        draw_surface(bgmask_surface, 0, 0);
        
        if (!arg4)
            gpu_set_blendmode(bm_normal);
        else
            reset_blendmode();
        
        surface_reset_target();
        draw_surface(bgclip_surface, arg0 - x1, arg1 - y1);
    }
    
    if (bgalpha > 0)
        draw_sprite_ext(arg2, arg3, arg0, arg1, image_xscale, image_yscale, image_angle, image_blend, bgalpha);
}
