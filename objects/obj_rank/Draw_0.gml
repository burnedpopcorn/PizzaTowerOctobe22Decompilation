shader_set(global.Pal_Shader);

if (global.collect >= global.collectN)
    pal_swap_set(obj_player1.spr_palette, obj_player1.paletteselect, false);

if (global.collectN > global.collect)
    pal_swap_set(obj_player2.spr_palette, obj_player2.paletteselect, false);

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
shader_reset();
var c = 16777215;
var xx = 523;
var cash_y = 0;
var sep = 89;
var i = array_length(toppin) - 1;

while (i >= 0)
{
    if (toppin[i] == 0)
        c = 0;
    else
        c = 16777215;
    
    if (toppin[i] == 1)
    {
        switch (i)
        {
            case 0:
                cash_y = -60;
                break;
            
            case 1:
                cash_y = -40;
                break;
            
            case 2:
                cash_y = -22;
                break;
            
            case 3:
                cash_y = -52;
                break;
            
            case 4:
                cash_y = -46;
                break;
        }
        
        draw_sprite_ext(spr_ranktoppins_cash, 0, xx + (sep * i), toppin_y[i] + cash_y, 1, toppin_yscale[i], 0, c, 1);
    }
    
    draw_sprite_ext(spr_ranktoppins, i, xx + (sep * i), toppin_y[i], 1, toppin_yscale[i], 0, c, 1);
    i--;
}
