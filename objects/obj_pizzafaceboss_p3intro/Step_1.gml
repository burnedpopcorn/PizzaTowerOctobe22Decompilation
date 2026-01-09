switch (introstate)
{
    case 0:
        hsp = 0;
        vsp = 0;
        
        if (floor(image_index) == (image_number - 1))
        {
            image_index = image_number - 1;
            introbuffer = 120;
            introstate++;
        }
        
        break;
    
    case 1:
        image_index = image_number - 1;
        
        if (introbuffer > 0)
        {
            introbuffer--;
        }
        else
        {
            sprite_index = spr_pizzahead_phase3_intro2;
            image_index = 0;
            introstate++;
        }
        
        break;
    
    case 2:
        if (floor(image_index) >= 50)
        {
            image_xscale = -1;
        }
        else if (floor(image_index) >= 16)
        {
            with (obj_player)
            {
                if (sprite_index != spr_player_gnomecutscene2)
                {
                    sprite_index = spr_player_gnomecutscene2;
                    image_index = 0;
                }
                else if (floor(image_index) == (image_number - 1))
                {
                    image_index = image_number - 1;
                }
            }
        }
        
        if (floor(image_index) >= 49)
        {
            introstate++;
            sprite_index = spr_pizzahead_giddy;
            image_xscale = 1;
        }
        
        break;
    
    case 3:
        with (obj_player)
        {
            if (floor(image_index) == (image_number - 1))
                image_index = image_number - 1;
        }
        
        hsp = 7;
        
        if (place_meeting(x + 64, y, obj_solid))
        {
            hsp = 0;
            sprite_index = spr_pizzahead_grabitem;
            image_index = 0;
            introstate++;
        }
        
        break;
    
    case 4:
        with (obj_player)
        {
            if (floor(image_index) == (image_number - 1))
                image_index = image_number - 1;
        }
        
        if (floor(image_index) == (image_number - 1))
        {
            sprite_index = spr_pizzahead_throwaway;
            image_index = 0;
            introstate++;
            var b = proparr[prop];
            prop++;
            
            with (instance_create(x, y, obj_pizzafacep3_prop))
            {
                image_speed = 0.35;
                image_xscale = -1;
                stunspr = b[0];
                angryspr = b[1];
                mask_index = b[2];
                vsp = -11;
                hsp = b[3];
            }
        }
        
        break;
    
    case 5:
        with (obj_player)
        {
            if (floor(image_index) == (image_number - 1))
                image_index = image_number - 1;
        }
        
        if (floor(image_index) >= 11)
        {
            if (prop < array_length(proparr))
            {
                sprite_index = spr_pizzahead_grabitem;
                image_index = 0;
                introstate = 4;
            }
            else
            {
                sprite_index = spr_pizzahead_idle;
                image_xscale = -1;
                introstate++;
            }
        }
        
        break;
    
    case 6:
        with (obj_player)
        {
            if (floor(image_index) == (image_number - 1))
                image_index = image_number - 1;
        }
        
        var t = true;
        
        with (obj_pizzafacep3_prop)
        {
            if (!start)
                t = false;
        }
        
        if (t)
        {
            introstate++;
            sprite_index = spr_pizzahead_phase3_intro2;
            image_index = 50;
            introbuffer = 50;
        }
        
        break;
    
    case 7:
        with (obj_player)
        {
            if (floor(image_index) == (image_number - 1))
                image_index = image_number - 1;
        }
        
        if (floor(image_index) == (image_number - 1))
            image_index = image_number - 1;
        
        if (introbuffer > 0)
        {
            introbuffer--;
        }
        else
        {
            with (obj_player1)
            {
                sprite_index = spr_player_gnomecutscene3;
                image_index = 0;
                other.introstate++;
                other.introbuffer = 50;
            }
        }
        
        break;
    
    case 8:
        with (obj_player1)
        {
            if (sprite_index == spr_player_gnomecutscene3 && floor(image_index) == (image_number - 1))
                sprite_index = spr_player_gnomecutscene4;
        }
        
        if (floor(image_index) == (image_number - 1))
            image_index = image_number - 1;
        
        if (introbuffer > 0)
        {
            introbuffer--;
        }
        else
        {
            shot = false;
            
            with (obj_player1)
            {
                sprite_index = spr_pizzahead_pepintro;
                image_index = 0;
                image_speed = 0.35;
            }
            
            introstate++;
        }
        
        break;
    
    case 9:
        if (floor(image_index) == (image_number - 1))
        {
            if (sprite_index == spr_pizzahead_intro2)
                image_index = image_number - 1;
            else
                image_index = image_number - 3;
        }
        
        if (obj_player1.image_index >= 20 && !shot)
        {
            fmod_event_one_shot("event:/sfx/pep/screamboss");
            shot = true;
            sprite_index = spr_pizzahead_phase3_intro3;
            
            with (obj_camera)
            {
                shake_mag = 15 / room_speed;
                shake_mag_acc = 4 / room_speed;
            }
            
            with (obj_pizzafacep3_prop)
            {
                if (angryspr != spr_pepperman_sour)
                {
                    hsp = irandom_range(8, 10);
                    vsp = -11;
                    use_collision = false;
                }
                else
                {
                    other.peppermanid = id;
                    hsp = 4;
                    angryspr = spr_pepperman_scared;
                    sprite_index = spr_pepperman_scared;
                }
            }
        }
        
        if (floor(obj_player1.image_index) == (obj_player1.image_number - 1))
        {
            introstate++;
            introbuffer = 0;
        }
        
        break;
    
    case 10:
        if (floor(image_index) == (image_number - 1))
            image_index = image_number - 3;
        
        if (introbuffer > 0)
        {
            introbuffer--;
        }
        else
        {
            introstate++;
            
            with (obj_player1)
            {
                hsp = 10;
                sprite_index = spr_player_lunge;
                image_index = 7;
            }
        }
        
        break;
    
    case 11:
        with (obj_player1)
        {
            if (floor(image_index) == (image_number - 1))
                image_index = image_number - 1;
        }
        
        if (obj_player1.x >= (peppermanid.x - 200))
        {
            introstate++;
            camzoom = 1;
            introbuffer = 130;
            
            with (obj_music)
                fmod_event_instance_set_parameter(music.event, "state", 3, false);
            
            instance_create(0, 0, obj_pizzahead_blackfade);
        }
        
        break;
    
    case 12:
        with (obj_player1)
        {
            if (floor(image_index) == (image_number - 1))
                image_index = image_number - 6;
        }
        
        camera_set_view_size(view_camera[0], SCREEN_WIDTH * camzoom, SCREEN_HEIGHT * camzoom);
        camzoom = lerp(camzoom, 0.5, 0.07);
        obj_player1.hsp = 1;
        obj_player1.image_speed = Approach(obj_player1.image_speed, 0.1, 0.1);
        peppermanid.image_speed = Approach(peppermanid.image_speed, 0.1, 0.1);
        
        if (obj_player1.x > (peppermanid.x - 50))
        {
            obj_player1.x = peppermanid.x - 50;
            obj_player1.hsp = 0;
        }
        
        if (introbuffer > 0)
        {
            introbuffer--;
        }
        else
        {
            introbuffer = 80;
            introstate++;
        }
        
        break;
    
    case 13:
        with (obj_player1)
        {
            if (floor(image_index) == (image_number - 1))
                image_index = image_number - 6;
        }
        
        if (introbuffer > 0)
        {
            introbuffer--;
        }
        else
        {
            introstate++;
            
            with (instance_create(0, 0, obj_pizzahead_whitefade))
                whitefade = 1.5;
            
            instance_destroy(peppermanid);
            instance_destroy();
            
            with (obj_bosscontroller)
                player_hp = player_maxhp;
            
            introstate++;
            
            with (instance_create(obj_player1.x, obj_player1.y, obj_pepperman))
            {
                elitehit = 5;
                instance_destroy(spotlightID);
                state = states.grabbed;
                pizzahead = true;
                grabbedby = 1;
                camzoom = 0.5;
                
                with (obj_player1)
                {
                    state = states.normal;
                    baddiegrabbedID = other.id;
                }
                
                with (obj_bosscontroller)
                {
                    boss_hpsprite = spr_bossfight_pepperhp;
                    boss_palette = spr_bossfight_pepperpalette;
                    boss_rowmax = 1;
                }
                
                instance_destroy(obj_pizzaheadTV_bg);
                instance_destroy(obj_pizzaheadTVspawner);
                instance_create_unique(0, 0, obj_pizzaface_thunderdark);
                var lay = layer_get_id("Backgrounds_2");
                var lay1 = layer_get_id("Backgrounds_scroll");
                var lay2 = layer_get_id("Backgrounds_scroll2");
                var bg = layer_background_get_id(lay);
                var bg1 = layer_background_get_id(lay1);
                var bg2 = layer_background_get_id(lay2);
                alarm[7] = 5;
                layer_set_visible("Backgrounds_zigzag1", false);
                layer_set_visible("Backgrounds_rain", true);
                layer_background_change(bg, bg_pizzaface_p3_sky);
                layer_background_change(bg2, bg_pizzaface_p3_sky1);
                layer_background_change(bg1, bg_pizzaface_p3_sky2);
                layer_hspeed(lay2, 2);
                layer_hspeed(lay1, 1.5);
            }
        }
        
        break;
}

mask_index = spr_pizzahead_idle;
scr_collide();
