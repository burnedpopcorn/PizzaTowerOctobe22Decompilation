if (!flash)
{
    shader_set(global.Pal_Shader);
    pal_swap_set(spr_fakepeppinopalette, paletteselect, false);
}
else
{
    shader_set(shd_hit);
}

draw_self();
shader_reset();
