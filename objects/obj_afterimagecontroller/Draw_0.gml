for (var i = 0; i < ds_list_size(global.afterimage_list); i++)
{
    var b = global.afterimage_list[| i];
    
    with (b)
    {
        if (visible)
        {
            b = image_blend;
            var a = other.alpha[identifier];
            var shd = false;
            
            if (identifier == afterimagetype.firemouth)
            {
                a = alpha;
                shd = true;
                shader_set(shd_color_afterimage);
                shader_set_uniform_f(other.shd_color_red, 0.97);
                shader_set_uniform_f(other.shd_color_green, 0.43);
                shader_set_uniform_f(other.shd_color_blue, 0.09);
            }
            else if (identifier == afterimagetype.blue)
            {
                a = alpha;
                shd = true;
                shader_set(shd_color_afterimage);
                shader_set_uniform_f(other.shd_color_red, 0.17);
                shader_set_uniform_f(other.shd_color_green, 0.49);
                shader_set_uniform_f(other.shd_color_blue, 0.9);
            }
            else if (identifier == afterimagetype.red)
            {
                a = alpha;
                shd = true;
                shader_set(shd_color_afterimage);
                shader_set_uniform_f(other.shd_color_red, 0.8745098039215686);
                shader_set_uniform_f(other.shd_color_green, 0.1843137254901961);
                shader_set_uniform_f(other.shd_color_blue, 0);
            }
            else if (identifier == afterimagetype.blur)
            {
                a = alpha;
                b = get_dark(image_blend, obj_drawcontroller.use_dark);
                
                if (instance_exists(playerid) && playerid.usepalette)
                {
                    shd = true;
                    shader_set(global.Pal_Shader);
                    pal_swap_set(playerid.spr_palette, playerid.paletteselect, false);
                }
            }
            
            draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, b, a);
            
            if (shd)
                shader_reset();
        }
    }
}
