switch (state)
{
    case 0:
        var ty = room_height + 200;
        
        with (towerID)
        {
            hitY = Approach(hitY, ty, 1);
            
            if (hitY > ystart)
                y = hitY + irandom_range(-1, 1);
            else
                y = ystart + irandom_range(-1, 1);
            
            x = xstart + irandom_range(-1, 1);
            
            if (other.puffbuffer > 0)
                other.puffbuffer--;
            else if (hitY <= room_height)
            {
                other.puffbuffer = 10 + irandom(15);
                
                with (instance_create(x + irandom_range(-48, 48), 259 + irandom_range(-16, 16), obj_endingeffect))
                {
                    sprite_index = spr_towerending_puff;
                    depth = choose(-4, -6);
                }
            }
        }
        
        if (towerID.y == ty)
        {
            state++;
            whitefadein = true;
        }
        
        break;
    
    case 1:
        if (whitefadein)
        {
            whitefade = Approach(whitefade, 2, 0.05);
            
            if (whitefade >= 2)
            {
                whitefadein = false;
                instance_destroy(obj_introprop);
            }
        }
        else
        {
            whitefade = Approach(whitefade, 0, 0.05);
            
            if (whitefade <= 0)
            {
                state++;
                spawn_buffer = 90;
            }
        }
        
        break;
    
    case 2:
        credits_y -= 1;
        
        if (obj_player1.key_up)
            credits_y -= 4;
        else if (obj_player1.key_down)
            credits_y += 4;
        
        if (credits_y < -(credits_height + 250))
            state++;
        
        if (spawn_buffer > 0)
            spawn_buffer--;
        else
        {
            spawn_buffer = 180 + irandom_range(-30, 40);
            
            repeat (irandom(3) + 1)
            {
                with (instance_create(room_width + 300 + irandom(100), 403, obj_endingprop))
                {
                    sprite_index = other.spawn_arr[irandom(array_length(other.spawn_arr) - 1)];
                    spd = irandom_range(3, 6);
                    image_speed = 0.35;
                    
                    if (sprite_index == spr_pepbat_move || sprite_index == spr_ufolive || sprite_index == spr_kentukybomber_move || sprite_index == spr_ghoul_attack || sprite_index == spr_ancho)
                        y = irandom_range(160, 288);
                    
                    if (sprite_index == spr_tank_walk)
                        y++;
                    
                    if (sprite_index == spr_ghostknight_move)
                        image_alpha = 0.5;
                }
            }
        }
        
        break;
    
    case 3:
        fade = Approach(fade, 2, 0.05);
        
        if (fade >= 2)
        {
            state++;
            introbuffer = 380;
            instance_destroy(obj_endingprop);
            
            with (instance_create(0, 0, obj_introprop))
            {
                sprite_index = spr_theendshot;
                depth = -6;
            }
        }
        
        break;
    
    case 4:
        fade = Approach(fade, 0, 0.05);
        
        if (introbuffer > 0)
            introbuffer--;
        else
            state++;
        
        break;
    
    case 5:
        fade = Approach(fade, 2, 0.05);
        
        if (fade >= 2)
        {
            state++;
            introbuffer = 40;
            instance_destroy(obj_introprop);
            
            with (instance_create(0, 0, obj_introprop))
            {
                sprite_index = spr_towerending;
                depth = -6;
            }
        }
        
        break;
    
    case 6:
        fade = Approach(fade, 0, 0.1);
        
        if (fade <= 0)
        {
            if (introbuffer > 0)
                introbuffer--;
            else
            {
                state++;
                fade = 0.5;
            }
        }
        
        break;
    
    case 7:
        if (obj_player1.key_jump)
        {
            with (obj_player)
                state = states.titlescreen;
            
            room_goto(Realtitlescreen);
        }
        
        break;
}
