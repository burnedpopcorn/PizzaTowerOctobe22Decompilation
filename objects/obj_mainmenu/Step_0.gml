scr_getinput();

switch (state)
{
    case states.titlescreen:
        currentselect = -1;
        
        if (key_jump)
        {
            state = states.normal;
            currentselect = 0;
            visualselect = 0;
            sprite_index = spr_titlepep_forwardtoleft;
            image_index = 0;
        }
        
        break;
    
    case states.normal:
        if (sprite_index != spr_titlepep_punch && sprite_index != spr_titlepep_angry)
        {
            currentselect += (key_left2 + key_right2);
            currentselect = clamp(currentselect, 0, 2);
            
            if (currentselect != visualselect && (sprite_index == spr_titlepep_left || sprite_index == spr_titlepep_middle || sprite_index == spr_titlepep_right))
            {
                visualselect = Approach(visualselect, currentselect, 1);
                image_index = 0;
                
                if (visualselect == 0 && sprite_index == spr_titlepep_middle)
                    sprite_index = spr_titlepep_middletoleft;
                
                if (visualselect == 1 && sprite_index == spr_titlepep_left)
                    sprite_index = spr_titlepep_lefttomiddle;
                
                if (visualselect == 2 && sprite_index == spr_titlepep_middle)
                    sprite_index = spr_titlepep_middletoright;
                
                if (visualselect == 1 && sprite_index == spr_titlepep_right)
                    sprite_index = spr_titlepep_righttomiddle;
            }
            
            if (floor(image_index) == (image_number - 1))
            {
                switch (sprite_index)
                {
                    case spr_titlepep_forwardtoleft:
                    case spr_titlepep_middletoleft:
                        sprite_index = spr_titlepep_left;
                        break;
                    
                    case spr_titlepep_lefttomiddle:
                    case spr_titlepep_righttomiddle:
                        sprite_index = spr_titlepep_middle;
                        break;
                    
                    case spr_titlepep_middletoright:
                        sprite_index = spr_titlepep_right;
                        break;
                }
            }
        }
        else if (sprite_index == spr_titlepep_angry)
        {
            y = ystart;
            
            if (angrybuffer > 0)
            {
                angrybuffer--;
            }
            else
            {
                sprite_index = savedsprite;
                image_index = savedindex;
                image_speed = 0.35;
            }
        }
        else
        {
            if (vsp < 20)
                vsp += 0.5;
            
            y += vsp;
            
            if (y >= ystart && vsp > 0)
            {
                y = ystart;
                vsp = 0;
            }
        }
        
        if (key_jump)
        {
            state = states.transitioncutscene;
            alarm[0] = 80;
            fmod_event_one_shot("event:/sfx/misc/collectpizza");
            
            switch (currentselect)
            {
                case 0:
                    sprite_index = spr_titlepep_left;
                    break;
                
                case 1:
                    sprite_index = spr_titlepep_middle;
                    break;
                
                case 2:
                    sprite_index = spr_titlepep_right;
                    break;
            }
        }
        
        break;
}

with (obj_menutv)
{
    if (trigger == other.currentselect)
        selected = true;
    else
        selected = false;
}
