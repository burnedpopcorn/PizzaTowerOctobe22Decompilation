if (use_dark)
{
    for (var i = 0; i < array_length(objdark_arr); i++)
    {
        with (objdark_arr[i])
        {
            if (visible)
            {
                var b = get_dark(image_blend, other.use_dark);
                var ix = image_xscale;
                
                if (object_index == obj_vigilantecow)
                    ix = xscale;
                
                draw_sprite_ext(sprite_index, image_index, x, y, ix, image_yscale, image_angle, b, image_alpha);
            }
        }
    }
}

if (obj_player1.finisher || obj_player2.finisher || (obj_player.state == states.playersuperattack && obj_player.superattackstate == states.transitioncutscene))
    finisher_alpha = Approach(finisher_alpha, 0.3, 0.1);
else if (finisher_alpha > 0)
    finisher_alpha = Approach(finisher_alpha, 0, 0.02);

if (finisher_alpha > 0)
{
    draw_set_alpha(finisher_alpha);
    draw_rectangle_color(-32, -32, room_width + 32, room_height + 32, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
}

var _kungfu = global.kungfu;

with (obj_baddie)
    draw_enemy(_kungfu, true);

shader_set(global.Pal_Shader);

with (obj_sausageman_dead)
{
    if (visible && bbox_in_camera(view_camera[0], 32))
    {
        pal_swap_set(spr_palette, paletteselect, false);
        var b = get_dark(image_blend, other.use_dark);
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, angle, b, image_alpha);
    }
}

with (obj_heatafterimage)
{
    if (visible)
    {
        pal_swap_set(obj_player1.spr_palette, obj_player1.paletteselect, false);
        draw_sprite_ext(obj_player1.sprite_index, obj_player1.image_index, x, y, obj_player1.xscale, obj_player1.yscale, 1, c_white, alpha);
    }
}

with (obj_player2)
{
    if (visible && state != states.titlescreen && bbox_in_camera(view_camera[0], 32))
        draw_player();
}

with (obj_player1)
{
    if (visible && state != states.titlescreen && bbox_in_camera(view_camera[0], 32))
        draw_player();
}

shader_set(shd_hit);

with (obj_baddie)
{
    var _stun = 0;
    
    if (state == states.stun && object_index != obj_pizzaball)
        _stun = 25;
    
    if (visible && flash && bbox_in_camera(view_camera[0], 32))
        draw_sprite_ext(sprite_index, image_index, x, y + _stun, xscale * image_xscale, yscale, angle, image_blend, image_alpha);
}

with (obj_player)
{
    if (visible && flash && bbox_in_camera(view_camera[0], 32))
        draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);
}

with (obj_deadjohnparent)
{
    if (visible && flash && bbox_in_camera(view_camera[0], 32))
        draw_sprite_ext(sprite_index, image_index, x + hurtx, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

with (obj_smallnumber)
{
    if (visible && flash)
    {
        draw_set_font(global.smallnumber_fnt);
        draw_set_halign(fa_center);
        draw_text(x, y, number);
    }
}

for (var i = 0; i < array_length(flash_arr); i++)
{
    with (flash_arr[i])
    {
        if (visible && flash)
            event_perform(ev_draw, ev_draw_normal);
    }
}

shader_reset();
