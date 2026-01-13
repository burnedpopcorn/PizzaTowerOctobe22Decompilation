if (state != states.transitioncutscene && state != states.actor)
    draw_self();
else if (state == states.transitioncutscene)
{
    draw_set_alpha(orangealpha);
    
    with (playerid)
    {
        shader_set(shd_firemouth_afterimage);
        draw_sprite_ext(sprite_index, image_index, x, y, xscale, image_yscale, image_angle, image_blend, image_alpha);
        shader_reset();
    }
    
    draw_set_alpha(1);
    
    with (obj_firemouthflame)
        draw_self();
}
else if (state == states.actor)
{
    draw_rectangle_color(camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]), camera_get_view_x(view_camera[0]) + SCREEN_WIDTH, camera_get_view_y(view_camera[0]) + SCREEN_HEIGHT, c_white, c_white, c_white, c_white, false);
    
    with (playerid)
    {
        shader_set(global.Pal_Shader);
        var ps = paletteselect;
        
        if (global.noisejetpack)
            ps = 2;
        
        pal_swap_set(spr_palette, ps, false);
        draw_sprite_ext(sprite_index, image_index, x, y, xscale, image_yscale, image_angle, image_blend, image_alpha);
        shader_reset();
    }
    
    with (obj_firemouthflame)
        draw_self();
}
