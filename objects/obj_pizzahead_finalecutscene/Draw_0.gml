if (state != states.superslam)
{
    draw_self();
}
else
{
    if (!pizzahead_front)
        draw_sprite(spr_pizzahead_hurt, 0, x + pizzahead_x, y);
    
    shader_set(global.Pal_Shader);
    pal_swap_set(spr_peppalette, 1, false);
    draw_self();
    shader_reset();
    
    if (pizzahead_front)
        draw_sprite(spr_pizzahead_hurt, 0, x + pizzahead_x, y);
}
