switch (state)
{
    case states.fall:
        if (sprite_index == spr_stick_helicopter)
        {
            hsp = 0;
            vsp = 0;
            y += 5;
            
            if (abs(y - obj_stick_target.y) <= 100)
            {
                sprite_index = spr_stick_fall;
                image_index = 0;
            }
        }
        else if (sprite_index == spr_stick_fall)
        {
            if (grounded && vsp > 0)
            {
                sprite_index = spr_stick_land;
                image_index = 0;
            }
        }
        else if (ANIMATION_END)
        {
            state = states.normal;
        }
        
        break;
    
    case states.normal:
        if (arrowID == -4)
            arrowID = scr_create_uparrowhitbox();
        
        if (sprite_index != spr_stick_idleanim1 && sprite_index != spr_stick_idleanim2 && sprite_index != spr_stick_idleanim3)
            sprite_index = spr_stick_idle;
        else if (ANIMATION_END)
            sprite_index = spr_stick_idle;
        
        if (sprite_index == spr_stick_idle)
            idle++;
        
        if (idle >= 200)
        {
            sprite_index = choose(spr_stick_idleanim1, spr_stick_idleanim2, spr_stick_idleanim3);
            image_index = 0;
            idle = 0;
        }
        
        if (!drawing && place_meeting(x, y, obj_player))
            drawing = true;
        else if (drawing && !place_meeting(x, y, obj_player))
            drawing = false;
        
        if (drawing && obj_player1.key_up && (global.pigtotal - global.pigreduction) >= maxscore)
        {
            instance_destroy(arrowID);
            obj_stick_forsale.visible = false;
            ini_open_from_string(obj_savesystem.ini_str);
            ini_write_real(save, "unlocked", true);
            ini_write_real(save, "reduction", maxscore);
            global.pigreduction += maxscore;
            obj_savesystem.ini_str = ini_close();
            state = states.jump;
            sprite_index = spr_stick_takemoney1;
            image_index = 0;
            shot = false;
            drawing = false;
            gamesave_async_save();
            
            with (obj_player)
            {
                hsp = 0;
                vsp = 0;
                sprite_index = spr_idle;
                image_speed = 0.35;
                state = states.actor;
                xscale = -other.image_xscale;
            }
        }
        
        break;
    
    case states.jump:
        if (shot)
        {
            with (obj_player1)
                hsp = Approach(hsp, 0, 0.1);
        }
        
        if (sprite_index == spr_stick_takemoney1)
        {
            if (floor(image_index) >= 16 && !shot)
            {
                shot = true;
                fmod_event_one_shot_3d("event:/sfx/pep/bumpwall", x, y);
                
                with (obj_player1)
                {
                    hsp = -xscale * 4;
                    sprite_index = spr_bump;
                }
            }
            
            if (ANIMATION_END)
            {
                image_xscale *= -1;
                sprite_index = spr_stick_takemoney2;
                image_index = 0;
            }
        }
        else if (sprite_index == spr_stick_takemoney2)
        {
            hsp = image_xscale * 4;
            
            if (abs(x - xstart) >= 200 || (place_meeting(x + sign(hsp), y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_slope)))
            {
                hsp = 0;
                sprite_index = spr_stick_leave;
                image_index = 0;
            }
        }
        else if (sprite_index == spr_stick_leave)
        {
            vsp = 0;
            
            if (floor(image_index) >= 10)
                y -= 4;
            
            if (ANIMATION_END)
                sprite_index = spr_stick_helicopter;
        }
        else
        {
            vsp = 0;
            y -= 8;
            
            if (y <= (camera_get_view_y(view_camera[0]) - 150))
            {
                with (obj_stick_forsale)
                {
                    first = true;
                    unlocked = true;
                    
                    with (instance_create(x, y, obj_stick_gateprop))
                    {
                        targetRoom = other.targetRoom;
                        
                        if (room != tower_5)
                        {
                            sprite_index = other.gate_sprite;
                            bgsprite = other.bgsprite;
                        }
                        else
                        {
                            sprite_index = spr_doorunvisited;
                        }
                        
                        depth = 250;
                        y_to = other.y;
                        y += sprite_get_height(sprite_index);
                    }
                    
                    instance_destroy();
                }
                
                with (obj_player1)
                {
                    state = states.normal;
                    landAnim = false;
                }
                
                instance_destroy();
            }
        }
        
        break;
}

money_y = Wave(-5, 5, 2, 2);

if (sprite_index != spr_stick_helicopter)
    scr_collide();
