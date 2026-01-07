if (!surface_exists(surf))
    surf = surface_create(room_width, room_height);

if (!surface_exists(surffinal))
    surffinal = surface_create(room_width, room_height);

surface_set_target(surf);
draw_clear_alpha(c_black, 0);
draw_set_alpha(1);
draw_rectangle_color(0, 0, room_width, room_height, c_white, c_white, c_white, c_white, false);
gpu_set_blendmode(bm_subtract);
draw_set_color(c_black);
draw_sprite_ext(bg_pizzaface1, 0, 0, 0, 1, 1, 0, c_black, 1);
draw_sprite_ext(bg_pizzaface1_2, 0, 0, 0, 1, 1, 0, c_black, 1);

for (var i = 0; i < array_length(dark_arr); i++)
{
    var b = dark_arr[i];
    
    with (b)
    {
        if (visible)
        {
            if (object_index == obj_player1 || object_index == obj_player2)
                draw_sprite_ext(sprite_index, image_index, x, y, xscale, image_yscale, 0, c_black, 1);
            else if (object_get_parent(object_index) == 555)
                draw_enemy(false, false, c_black);
            else
                draw_self();
        }
    }
}

gpu_set_blendmode(bm_normal);
draw_set_color(c_white);
surface_reset_target();
surface_set_target(surffinal);
draw_clear_alpha(c_black, 0);
draw_set_alpha(dark);
draw_rectangle_color(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);
gpu_set_blendmode(bm_subtract);
draw_surface(surf, 0, 0);
gpu_set_blendmode(bm_normal);
surface_reset_target();
draw_surface(surffinal, 0, 0);
draw_rectangle_color(0, 0, -200, room_height, c_black, c_black, c_black, c_black, false);
draw_rectangle_color(room_width, 0, room_width + 200, room_height, c_black, c_black, c_black, c_black, false);
draw_rectangle_color(-100, room_height, room_width + 100, room_height + 200, c_black, c_black, c_black, c_black, false);
