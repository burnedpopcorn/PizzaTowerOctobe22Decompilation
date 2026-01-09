if (room == editor_room)
    exit;

draw_set_font(lang_get_font("bigfont"));
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_set_alpha(1);

if (is_bossroom() || instance_exists(obj_tutorialbook))
    exit;

var collect_x = irandom_range(-collect_shake, collect_shake);
var collect_y = irandom_range(-collect_shake, collect_shake);
var _cx = tv_x + combo_posX;
var _cy = tv_y + 117 + hud_posY + combo_posY;
var _perc = global.combotime / 60;
var _minX = _cx - 56;
var _maxX = _cx + 59;
combofill_x = lerp(combofill_x, _minX + ((_maxX - _minX) * _perc), 0.5);
combofill_y = _cy;
draw_sprite(spr_tv_combobubblefill, combofill_index, combofill_x, combofill_y);
draw_sprite(spr_tv_combobubble, -1, _cx, _cy);
draw_set_font(global.combofont2);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
var _tx = _cx - 64;
var _ty = _cy - 12;
var _str = string(global.combo);
var num = string_length(_str);

for (var i = num; i > 0; i--)
{
    var char = string_char_at(_str, i);
    draw_text(_tx, _ty, char);
    _tx -= 22;
    _ty -= 8;
}

if (room != strongcold_endscreen)
{
    draw_sprite_ext(spr_tv_bgfinal, tv_bg_index, tv_x + collect_x, tv_y + collect_y + hud_posY, 1, 1, 0, c_white, alpha);
    draw_sprite_ext(sprite_index, image_index, tv_x + collect_x, tv_y + collect_y + hud_posY, 1, 1, 0, c_white, alpha);
    
    if (state == states.tv_whitenoise)
        draw_sprite(spr_tv_whitenoise, tv_trans, tv_x + collect_x, tv_y + collect_y + hud_posY);
}

if (bubblespr != noone)
    draw_sprite_ext(bubblespr, bubbleindex, SCREEN_WIDTH - 448, 53, 1, 1, 1, c_white, alpha);

if (!surface_exists(promptsurface))
    promptsurface = surface_create(290, 102);

surface_set_target(promptsurface);
draw_clear_alpha(c_black, 0);
draw_set_font(font1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

if (bubblespr == spr_tv_bubble)
{
    promptx -= promptspd;
    
    if (bubblespr != spr_tv_bubbleclose && promptx < (350 - string_width(prompt)))
    {
        bubblespr = spr_tv_bubbleclose;
        bubbleindex = 0;
    }
    
    draw_text_color(promptx - 350, 50, prompt, c_black, c_black, c_black, c_black, 1);
}

draw_set_halign(fa_left);
surface_reset_target();
draw_surface(promptsurface, SCREEN_WIDTH - 610, 0);
draw_set_font(global.smallnumber_fnt);
draw_set_halign(fa_center);

if (global.panic)
{
    var _fill = global.fill;
    var _currentbarpos = chunkmax - _fill;
    _perc = _currentbarpos / chunkmax;
    var _max_x = 299;
    var _barpos = _max_x * _perc;
    
    if (!surface_exists(bar_surface))
        bar_surface = surface_create(298, 30);
    
    var _barfillpos = floor(_barpos) + 13;
    
    if (_barfillpos > 0)
    {
        surface_resize(bar_surface, _barfillpos, 30);
        surface_set_target(bar_surface);
        draw_clear_alpha(c_black, 0);
        var clip_x = timer_x + 3;
        var clip_y = timer_y + 5;
        
        for (var i = 0; i < 3; i++)
            draw_sprite(spr_timer_barfill, 0, barfill_x + (i * 173), 0);
        
        surface_reset_target();
        draw_surface(bar_surface, clip_x, clip_y);
    }
    
    draw_sprite(spr_timer_bar, -1, timer_x, timer_y);
    draw_sprite(johnface_sprite, johnface_index, timer_x + 13 + _barpos, timer_y + 20);
    draw_sprite(pizzaface_sprite, pizzaface_index, timer_x + 320, timer_y + 10);
    var minutes = 0;
    var seconds = ceil(global.fill / 12);
    
    while (seconds > 59)
    {
        minutes++;
        seconds -= 60;
    }
    
    if (seconds < 10)
        seconds = concat("0", seconds);
    else
        seconds = string(seconds);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(global.bigfont);
    draw_text(timer_x + 153, timer_y + 18, concat(minutes, ":", seconds));
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
