text_xscale = (SCREEN_WIDTH - 64) / sprite_get_width(spr_tutorialbubble);

if (text_xscale != text_oldxscale)
    event_perform(ev_other, ev_room_start);

if (place_meeting(x, y, obj_player))
    sprite_index = spr_tutorialgranny_talk;
else
    sprite_index = spr_tutorialgranny_sleep;

switch (text_state)
{
    case states.titlescreen:
        text_y = Approach(text_y, -(text_sprite_height * text_yscale), 5);
        
        if (place_meeting(x, y, obj_player))
        {
            text_state = states.fall;
            text_vsp = 0;
        }
        
        break;
    
    case states.fall:
        text_y += text_vsp;
        
        if (text_vsp < 20)
            text_vsp += 0.5;
        
        if (text_y > text_ystart)
            text_state = states.normal;
        
        break;
    
    case states.normal:
        text_y = Approach(text_y, text_ystart, 2);
        
        if (!place_meeting(x, y, obj_player))
            text_state = states.titlescreen;
        
        break;
}

text_wave_x = Wave(-5, 5, 2, 10);
text_wave_y = Wave(-1, 1, 4, 0);
