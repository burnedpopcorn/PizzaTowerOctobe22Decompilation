function scr_pizzaface_arenaintro()
{
    x = room_width / 2;
    y = (room_height / 2) - 100;
    hsp = 0;
    vsp = 0;
    image_speed = 0.35;
    
    with (obj_player)
    {
        state = states.actor;
        image_speed = 0.35;
        xscale = 1;
        
        if (other.sprite_index == spr_pizzaface)
            sprite_index = spr_player_gnomecutscene1;
        
        if (floor(image_index) == (image_number - 1))
        {
            if (sprite_index == spr_player_gnomecutscene2)
                image_index = image_number - 1;
            else if (sprite_index == spr_player_gnomecutscene3)
                sprite_index = spr_player_gnomecutscene4;
        }
    }
    
    if (introbuffer > 0)
    {
        introbuffer--;
        
        if (floor(image_index) == (image_number - 1) && sprite_index == spr_pizzaface_intro1)
            image_index = image_number - 1;
    }
    else if (sprite_index == spr_pizzaface)
    {
        sprite_index = spr_pizzaface_intro1;
        image_index = 0;
        introbuffer = 80;
        
        with (obj_player)
        {
            sprite_index = spr_player_gnomecutscene2;
            image_index = 0;
        }
    }
    else if (sprite_index == spr_pizzaface_intro1)
    {
        sprite_index = spr_pizzaface_intro2;
        image_index = 0;
        
        with (obj_player)
        {
            fmod_event_one_shot("event:/sfx/pep/screamboss");
            sprite_index = spr_player_gnomecutscene3;
            image_index = 0;
        }
    }
    else if (floor(image_index) == (image_number - 1))
    {
        state = states.walk;
        spotlightID.expand = true;
        
        with (obj_player)
        {
            state = states.normal;
            sprite_index = spr_idle;
        }
    }
}

function scr_pizzaface_normal()
{
    while (place_meeting(x, y, obj_solid))
        x += ((x > (room_width / 2)) ? -1 : 1);
    
    image_speed = 0.35;
    
    if (flickertime <= 0)
    {
        image_xscale = 1;
        hsp = floatdir * 5;
        vsp = 0;
        var ty = room_height * 0.3;
        y = Approach(y, ty, 2);
        
        if (y != ty)
            on_y = false;
        else
            on_y = true;
        
        if (place_meeting(x + floatdir, y, obj_solid))
            floatdir *= -1;
        
        if (sprite_index != spr_pizzaface_nosespit1 && sprite_index != spr_pizzaface_nosespit2 && sprite_index != spr_pizzaface_nosespit3)
        {
            sprite_index = spr_pizzaface;
            
            if (y < (room_height / 2))
            {
                if (attackbuffer > 0)
                {
                    attackbuffer--;
                }
                else
                {
                    attackbuffer = 120 - (wastedhits * 15);
                    
                    if (nosespit)
                    {
                        nosespit = false;
                        sprite_index = spr_pizzaface_nosespit1;
                        image_index = 0;
                        nosecount = 0 + floor(wastedhits / 3);
                    }
                    else
                    {
                        nosespit = true;
                        state = states.pizzaface_ram;
                        sprite_index = spr_pizzaface_attackstart;
                        image_index = 0;
                        substate = states.arenaintro;
                        ramdir = point_direction(x, y, targetplayer.x + irandom_range(-50, 50), 402);
                        ramhsp = -lengthdir_x(6, ramdir);
                        ramvsp = -lengthdir_y(6, ramdir);
                        
                        if (x != targetplayer.x)
                            image_xscale = sign(targetplayer.x - x);
                        else if (ramhsp != 0)
                            image_xscale = sign(ramhsp);
                    }
                }
            }
        }
        else if (floor(image_index) == (image_number - 1))
        {
            if (sprite_index == spr_pizzaface_nosespit1)
            {
                sprite_index = spr_pizzaface_nosespit2;
                var b = baddie_arr[irandom_range(0, baddie_range - 1)];
                
                with (instance_create(x, y, obj_pizzafacebaddie))
                {
                    sprite_index = b[1];
                    content = b[0];
                    vsp = 10;
                }
            }
            else if (sprite_index == spr_pizzaface_nosespit2)
            {
                sprite_index = spr_pizzaface_nosespit3;
            }
            else if (sprite_index == spr_pizzaface_nosespit3)
            {
                if (nosecount > 0)
                {
                    nosecount--;
                    sprite_index = spr_pizzaface_nosespit1;
                }
                else
                {
                    sprite_index = spr_pizzaface;
                }
            }
        }
    }
    else
    {
        sprite_index = spr_pizzaface_hurt;
        
        if (grounded)
            hsp = Approach(hsp, 0, 0.25);
        
        if (place_meeting(x + hsp, y, obj_solid))
        {
            hsp *= -1;
            image_xscale *= -1;
        }
        
        if (grounded && vsp > 0 && flickertime > 0)
        {
            hsp = Approach(hsp, 0, 0.5);
            create_particle(x, y, particle.landcloud);
            vsp = -5;
            touchedground = true;
        }
    }
}

function scr_pizzaface_ram()
{
    switch (substate)
    {
        case states.arenaintro:
            ramhsp = Approach(ramhsp, 0, 0.3);
            ramvsp = Approach(ramvsp, 0, 0.3);
            hsp = ramhsp;
            vsp = ramvsp;
            
            if (floor(image_index) == (image_number - 1))
            {
                substate = states.pizzaface_ram;
                var s = wastedhits;
                ramhsp = lengthdir_x(18 + s, ramdir);
                ramvsp = lengthdir_y(18 + s, ramdir);
                sprite_index = spr_pizzaface_attack;
            }
            
            break;
        
        case states.pizzaface_ram:
            hsp = ramhsp;
            vsp = ramvsp;
            
            if (vsp < -5)
                vsp = 12;
            
            if ((vsp > 0 && grounded) || place_meeting(x + sign(hsp), y, obj_solid))
            {
                fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y);
                substate = states.land;
                landbuffer = 80;
                hitX = x;
                hitY = y;
                sprite_index = spr_pizzaface_attackland;
                image_index = 0;
                
                if (instance_number(obj_baddie) < 6 && instance_number(obj_pizzafacebaddie) < 6)
                {
                    var b = baddie_arr[irandom_range(0, baddie_range - 1)];
                    
                    with (instance_create(irandom_range(50, room_width - 50), room_height + 30, obj_pizzafacebaddie))
                    {
                        sprite_index = b[1];
                        content = b[0];
                    }
                }
                
                with (obj_camera)
                {
                    shake_mag = 3;
                    shake_mag_acc = 5 / room_speed;
                }
            }
            
            break;
        
        case states.land:
            hsp = 0;
            x = hitX + irandom_range(-1, 1);
            y = hitY + irandom_range(-1, 1);
            
            if (floor(image_index) == (image_number - 1))
            {
                substate = states.jump;
                sprite_index = spr_pizzaface_attackjump;
                image_index = 0;
                vsp = -14;
                x = hitX;
                y = hitY;
            }
            
            break;
        
        case states.jump:
            if (floor(image_index) == (image_number - 1))
                image_index = image_number - 1;
            
            if (vsp > 0)
            {
                substate = states.transitioncutscene;
                vsp = 0;
                sprite_index = spr_pizzaface_attackend;
                image_index = 0;
            }
            
            break;
        
        case states.transitioncutscene:
            vsp = 0;
            
            if (floor(image_index) == (image_number - 1))
                state = states.walk;
            
            break;
    }
}

function scr_pizzaface_transitioncutscene()
{
    image_speed = 0.35;
    hsp = 0;
    vsp = 0;
    
    switch (substate)
    {
        case states.transitioncutscene:
            sprite_index = spr_pizzahead_intro1;
            var tx = room_width / 2;
            var ty = room_height / 2;
            var _dir = point_direction(x, y, tx, ty);
            x += lengthdir_x(5, _dir);
            y += lengthdir_y(5, _dir);
            
            if (abs(x - tx) <= 10 && abs(y - ty) <= 10)
            {
                substate = states.hit;
                x = tx;
                y = ty;
                sprite_index = spr_pizzahead_intro2;
                image_index = 0;
            }
            
            break;
        
        case states.hit:
            if (floor(image_index) == (image_number - 1))
            {
                fmod_event_one_shot_3d("event:/sfx/misc/explosion", x, y);
                
                with (instance_create(x, y, obj_explosioneffect))
                    sprite_index = spr_bombexplosion;
                
                with (instance_create(x, y, obj_pizzafaceboss_p2))
                {
                    vsp = 0;
                    hsp = 0;
                    state = states.fall;
                    substate = states.jump;
                    sprite_index = spr_pizzahead_intro3;
                    
                    if (x != obj_player1.x)
                        image_xscale = sign(obj_player1.x - x);
                    
                    with (obj_bosscontroller)
                        bossID = other.id;
                }
                
                instance_destroy(id, false);
            }
            
            break;
    }
}
