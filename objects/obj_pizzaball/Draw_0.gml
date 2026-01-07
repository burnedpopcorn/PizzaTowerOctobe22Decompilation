draw_self();

if (arrow)
{
    with (player)
        draw_sprite_ext(spr_golf_aimuparrow, other.arrowindex, x + (32 * xscale), y - 32, xscale, 1, 0, c_white, 1);
}
