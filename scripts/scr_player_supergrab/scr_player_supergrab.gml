function scr_player_supergrab()
{
    if (pizzahead)
    {
        if (supergrabstate != states.finishingblow)
            camzoom = lerp(camzoom, 0.5, 0.08);
        else
            camzoom = lerp(camzoom, 1, 0.08);
    }
    else
    {
        camzoom = 1;
    }
    
    invtime = 30;
    
    switch (supergrabstate)
    {
        case states.punch:
            image_speed = 1.2;
            hsp = Approach(hsp, 0, 0.2);
            vsp = 0;
            baddiegrabbedID.image_speed = 0.35;
            baddiegrabbedID.x = x + (xscale * 20);
            baddiegrabbedID.y = y;
            
            if (baddiegrabbedID.sprite_index == baddiegrabbedID.stunfallspr)
                baddiegrabbedID.y += 25;
            
            if (ANIMATION_END)
            {
                if (punchcount > 0)
                {
                    fmod_event_one_shot_3d("event:/sfx/pep/punch", x, y);
                    hsp = xscale * 3;
                    punchcount--;
                    supergrabstate = states.hit;
                    hitX = x;
                    hitY = y;
                    hitLag = 2;
                    tauntstoredmovespeed = hsp;
                    
                    with (baddiegrabbedID)
                    {
                        image_speed = 0;
                        hitX = x;
                        hitY = y;
                        
                        repeat (3)
                        {
                            with (create_debris(x, y, spr_slapstar))
                                vsp = -irandom_range(8, 11);
                        }
                        
                        repeat (4)
                        {
                            with (create_debris(x, y, spr_baddiegibs))
                                vsp = -irandom_range(8, 11);
                        }
                        
                        instance_create(x + irandom_range(-40, 40), y + irandom_range(-40, 40), obj_parryeffect);
                    }
                    
                    image_index = 1;
                    image_speed = 0;
                    randomize_animations([spr_suplexmash1, spr_suplexmash2, spr_suplexmash3, spr_suplexmash4, spr_player_suplexmash5, spr_player_suplexmash6, spr_player_suplexmash7]);
                    
                    repeat (4 + irandom(6))
                    {
                        var _spd = 5 + irandom(6);
                        
                        with (create_blur_afterimage(x, y, sprite_index, image_index - 1, xscale))
                        {
                            hsp = choose(-_spd, _spd);
                            vsp = choose(-_spd, _spd);
                        }
                    }
                }
                else
                {
                    var h = -1;
                    
                    if (baddiegrabbedID.object_index == obj_pizzafaceboss_p3)
                        h = 1;
                    
                    if (baddiegrabbedID.elitehit > h)
                    {
                        with (baddiegrabbedID)
                        {
                            if (place_meeting(x, y, obj_solid))
                            {
                                x = other.x;
                                y = other.y;
                                
                                if (object_index == obj_pizzafaceboss_p3)
                                    y = other.y - 32;
                            }
                            
                            if (object_index == obj_pizzafaceboss)
                            {
                                x = clamp(x, 65, 885);
                                y = clamp(y, 0, 382);
                            }
                        }
                        
                        if (baddiegrabbedID.elitehit <= 1 && baddiegrabbedID.object_index != obj_pizzafaceboss_p3)
                            baddiegrabbedID.destroyable = true;
                        
                        sprite_index = spr_player_lungehit;
                        supergrabstate = states.finishingblow;
                        shot = false;
                    }
                    else
                    {
                        baddiegrabbedID.state = states.finale;
                        state = states.finale;
                        instance_create(room_width / 2, room_height / 2, obj_pizzahead_finalecutscene);
                        instance_create(0, 0, obj_pizzahead_whitefade);
                        camzoom = 1;
                    }
                }
            }
            
            break;
        
        case states.hit:
            hsp = 0;
            vsp = 0;
            x = hitX + irandom_range(-4, 4);
            y = hitY + irandom_range(-4, 4);
            
            with (baddiegrabbedID)
            {
                x = hitX + irandom_range(-4, 4);
                y = hitY + irandom_range(-4, 4);
            }
            
            if (hitLag > 0)
            {
                hitLag--;
            }
            else
            {
                x = hitX;
                y = hitY;
                hsp = tauntstoredmovespeed;
                supergrabstate = states.punch;
                
                with (baddiegrabbedID)
                {
                    x = hitX;
                    y = hitY;
                }
            }
            
            break;
        
        case states.finishingblow:
            if (!shot)
            {
                hsp = 0;
                vsp = 0;
            }
            
            if (floor(image_index) >= 3 && !shot)
            {
                fmod_event_one_shot_3d("event:/sfx/pep/punch", x, y);
                fmod_event_one_shot_3d("event:/sfx/enemies/killingblow", x, y);
                shot = true;
                movespeed = -xscale * 8;
                hsp = movespeed;
                
                with (baddiegrabbedID)
                {
                    hitX = x;
                    hitY = y;
                    hithsp = -image_xscale * 25;
                    hitvsp = -5;
                    linethrown = true;
                    mach2 = false;
                    state = states.hit;
                    
                    if (other.pizzahead)
                        hitLag = 15;
                    else
                        hitLag = 5;
                    
                    with (instance_create(x, y, obj_explosioneffect))
                    {
                        sprite_index = spr_bombexplosion;
                        image_index = 8;
                    }
                    
                    repeat (3)
                        create_debris(x, y, spr_slapstar);
                    
                    repeat (4)
                        create_debris(x, y, spr_baddiegibs);
                    
                    repeat (irandom(2) + 1)
                        instance_create(x + irandom_range(-70, 70), y + irandom_range(-70, 70), obj_parryeffect);
                }
                
                repeat (4 + irandom(6))
                {
                    var spd = 5 + irandom(6);
                    
                    with (create_blur_afterimage(x, y, sprite_index, image_index - 1, xscale))
                    {
                        hsp = choose(-spd, spd);
                        vsp = choose(-spd, spd);
                    }
                }
            }
            
            if (ANIMATION_END)
                image_index = image_number - 3;
            
            hsp = movespeed;
            
            if (grounded && vsp > 0)
            {
                movespeed = Approach(movespeed, 0, 0.2);
                
                if (movespeed == 0)
                {
                    state = states.normal;
                    landAnim = false;
                    camzoom = 1;
                }
            }
            
            break;
    }
    
    camera_set_view_size(view_camera[0], SCREEN_WIDTH * camzoom, SCREEN_HEIGHT * camzoom);
}
