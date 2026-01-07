function scr_pizzaface_p2_fall()
{
    image_speed = 0.35;
    hsp = 0;
    
    switch (substate)
    {
        case states.jump:
            vsp = 0;
            y -= 18;
            
            if (y < -600)
                substate = states.fall;
            
            break;
        
        case states.fall:
            if (y < 200)
            {
                y += 20;
                vsp = 0;
            }
            else
            {
                vsp = 20;
            }
            
            if (grounded && vsp > 0)
            {
                var lay = layer_get_id("Backgrounds_2");
                var bg = layer_background_get_id(lay);
                alarm[7] = 5;
                layer_set_visible("Backgrounds_1", true);
                layer_set_visible("Backgrounds_zigzag1", true);
                layer_background_change(bg, bg_pizzaface_p2_sky);
                fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y);
                substate = states.transitioncutscene;
                sprite_index = spr_pizzahead_intro4;
                image_index = 0;
                
                with (obj_bosscontroller)
                {
                    player_hp = player_maxhp;
                    boss_hpsprite = spr_bossfight_pizzaheadHP;
                    boss_palette = spr_bossfight_pizzaheadpalette;
                }
                
                with (obj_camera)
                {
                    shake_mag = 3;
                    shake_mag_acc = 5 / room_speed;
                }
            }
            
            break;
        
        case states.transitioncutscene:
            instance_create_unique(x, y, obj_pizzaheadTVspawner);
            
            if (x != targetplayer.x && floor(image_index) >= 31)
                image_xscale = sign(targetplayer.x - x);
            
            if (floor(image_index) == (image_number - 1))
            {
                state = states.walk;
                image_xscale = 1;
            }
            
            break;
    }
}

function scr_pizzaface_p2_normal()
{
    if (elitehit <= 0)
    {
        destroyable = true;
        instance_destroy();
    }
    
    if (instance_exists(obj_pistolpickup))
    {
        sprite_index = spr_pizzahead_idle;
        hsp = 0;
        vsp = 0;
    }
    else if (flickertime <= 0)
    {
        if (instance_exists(obj_pizzaheadportrait) || instance_exists(obj_forknightspawner))
            idle_buffer = 10;
        
        if (idle_buffer > 0)
        {
            idle_buffer--;
            hsp = 0;
            sprite_index = spr_pizzahead_idle;
        }
        else
        {
            sprite_index = spr_pizzahead_giddy;
            hsp = image_xscale * (10 + (wastedhits * 2));
            
            if (grounded && vsp > 0 && place_meeting(x + (sign(hsp) * 64), y, obj_solid))
            {
                state = states.fishing;
                hsp = 0;
                sprite_index = spr_pizzahead_grabitem;
                image_index = 0;
            }
        }
    }
    else
    {
        sprite_index = spr_pizzahead_hurt;
        
        if (grounded)
            hsp = Approach(hsp, 0, 0.25);
        
        if (grounded && vsp > 0 && flickertime > 0)
        {
            hsp = Approach(hsp, 0, 0.5);
            create_particle(x, y, particle.landcloud);
            vsp = -5;
            touchedground = true;
        }
    }
}

function scr_pizzaface_p2_look()
{
    hsp = 0;
    
    if (fishingbuffer > 0)
    {
        fishingbuffer--;
    }
    else if (fishcount > 0)
    {
        fishcount--;
        state = states.walk;
        image_xscale *= -1;
        sprite_index = spr_pizzahead_giddy;
    }
    else
    {
        state = states.fishing;
        fishingbuffer = 80;
        fishcount = irandom_range(1, 3);
    }
}

function scr_pizzaface_p2_fishing()
{
    hsp = 0;
    
    if (instance_exists(obj_pizzaheadswordstone) && abs(x - obj_pizzaheadswordstone.x) <= 120)
    {
        leveldown = false;
        state = UnknownEnum.Value_240;
        sprite_index = spr_pizzahead_pullinglevel2;
        image_index = 0;
    }
    else if (!global.pistol)
    {
        if (floor(image_index) == (image_number - 1))
        {
            saveddir = -image_xscale;
            hsp = 0;
            vsp = 0;
            state = states.shotgun;
            substate = states.throwing;
            sprite_index = spr_pizzahead_grabbox;
            image_index = 0;
        }
    }
    else if (floor(image_index) == (image_number - 1))
    {
        saveddir = -image_xscale;
        
        if (throwsword && lastattack != UnknownEnum.Value_0)
            leveldown = true;
        
        if (miniguncount > 0)
        {
            brick = false;
            state = states.shotgun;
            hsp = 0;
            vsp = 0;
            substate = states.throwing;
            sprite_index = spr_pizzahead_grabdynamite;
            image_index = 0;
            miniguncount = 0;
        }
        else
        {
            availablemoves = [];
            
            for (var i = 0; i < array_length(movecount); i++)
            {
                if (movecount[i] <= 1)
                    array_push(availablemoves, i);
            }
            
            var t;
            
            do
                t = availablemoves[irandom(array_length(availablemoves) - 1)];
            until (lastattack != t || array_length(availablemoves) <= 1);
            
            lastattack = t;
            idle_buffer = 0;
            
            switch (t)
            {
                case UnknownEnum.Value_0:
                    state = UnknownEnum.Value_240;
                    substate = 0;
                    sprite_index = spr_pizzahead_pullinglevel1;
                    image_index = 0;
                    shot = false;
                    
                    with (obj_camera)
                    {
                        shake_mag = 3;
                        shake_mag_acc = 1 / room_speed;
                    }
                    
                    break;
                
                case UnknownEnum.Value_3:
                    brick = true;
                    state = states.throwing;
                    brickcount = 1;
                    sprite_index = spr_pizzahead_ratballstart;
                    image_index = 0;
                    break;
                
                case UnknownEnum.Value_1:
                    state = UnknownEnum.Value_237;
                    shot = false;
                    sprite_index = spr_pizzahead_grabTV;
                    image_index = 0;
                    break;
                
                case UnknownEnum.Value_2:
                    sprite_index = spr_pizzahead_grabgun;
                    image_index = 0;
                    state = states.shotgun;
                    ammo = 20;
                    
                    if (image_xscale > 0)
                    {
                        minigun_angle = 225;
                        minigun_dir = -1;
                    }
                    else
                    {
                        minigun_angle = 315;
                        minigun_dir = 1;
                    }
                    
                    substate = states.mini;
                    attackbuffer = 1;
                    break;
            }
        }
    }
}

function boss_pizzahead_portraitthrow()
{
    if (floor(image_index) >= 44 && !shot)
    {
        shot = true;
        
        with (instance_create(x, y - 32, obj_pizzaheadportrait))
        {
            dir = -other.image_xscale;
            vsp = -18;
            spd += (other.wastedhits * 0.25);
            
            while (place_meeting(x, y, obj_solid))
                x += ((x > (room_width / 2)) ? -1 : 1);
        }
    }
    
    if (floor(image_index) == (image_number - 1))
    {
        image_xscale *= -1;
        state = states.walk;
    }
}

function boss_pizzahead_pullinglevel()
{
    if (sprite_index == spr_pizzahead_pullinglevel2)
    {
        var ix = floor(image_index);
        
        with (obj_pizzaheadswordstone)
        {
            if (ix < 8)
                y = ystart;
            else if (ix == 8)
                y = other.y + 64;
            else if (ix == 9)
                y = other.y + 99;
            else if (ix == 10)
                y = other.y + 118;
            else if (ix == 11)
                y = other.y + 141;
            else if (ix == 12)
                y = other.y + 159;
            else
                instance_destroy();
        }
    }
    
    if (floor(image_index) >= 22 && sprite_index == spr_pizzahead_pullinglevel1 && !shot)
    {
        shot = true;
        
        repeat (7 + irandom(5))
        {
            var _x = irandom_range(100, room_width - 100);
            _x = clamp(_x, 100, room_width - 100);
            
            with (instance_create(_x, room_height + 100, obj_forknight_pizzahead))
                vsp = -irandom_range(18, 26);
        }
    }
    
    if (floor(image_index) == (image_number - 1))
    {
        if (sprite_index == spr_pizzahead_pullinglevel1)
        {
            if (!instance_exists(obj_pizzaheadswordstone))
                instance_create(x + (42 * image_xscale), y + 33, obj_pizzaheadswordstone);
            
            image_index = image_number - 1;
            
            if (!instance_exists(obj_forknight_pizzahead) && !instance_exists(obj_medievalprojectile))
            {
                state = UnknownEnum.Value_240;
                sprite_index = spr_pizzahead_pullinglevel2;
                image_index = 0;
            }
        }
        else if (sprite_index == spr_pizzahead_pullinglevel2)
        {
            state = states.walk;
            image_xscale *= -1;
            idle_buffer = 0;
            leveldown = false;
            throwsword = false;
            instance_destroy(obj_pizzaheadswordstone);
        }
    }
}

function boss_pizzahead_throwing()
{
    hsp = 0;
    
    if (!brick)
    {
        if (floor(image_index) == (image_number - 1))
            state = states.walk;
    }
    else
    {
        if (sprite_index == spr_pizzahead_ratballstart)
        {
            if (floor(image_index) == (image_number - 1))
            {
                sprite_index = spr_pizzahead_ratballidle;
                image_xscale *= -1;
            }
        }
        else if (sprite_index == spr_pizzahead_ratballthrow)
        {
            if (floor(image_index) >= 18 && !shot)
            {
                shot = true;
                
                with (instance_create(x + (46 * image_xscale), y - 64, obj_pizzaheadbrickball))
                {
                    image_xscale = other.image_xscale;
                    var s1 = 14 + other.wastedhits;
                    var s2 = 23 + other.wastedhits;
                    grav += (other.wastedhits * 0.1);
                    calculate_jump_velocity(obj_player1.x, obj_player1.y, s1, grav);
                    
                    if (abs(hsp) <= 1 && (abs(vsp) <= 1 || vsp > 0))
                        calculate_jump_velocity(obj_player1.x, obj_player1.y, s2, grav);
                    
                    movespeed = abs(hsp);
                    
                    if (movespeed <= 4)
                        movespeed = 10;
                }
            }
            
            if (floor(image_index) == (image_number - 1))
                sprite_index = spr_pizzahead_ratballidle;
        }
        else if (sprite_index == spr_pizzahead_ratballcatch)
        {
            if (floor(image_index) == (image_number - 1))
                sprite_index = spr_pizzahead_ratballidle;
        }
        else if (sprite_index == spr_pizzahead_ratballend)
        {
            if (floor(image_index) == (image_number - 1))
                state = states.walk;
        }
        
        if (sprite_index == spr_pizzahead_ratballidle)
        {
            if (!instance_exists(obj_pizzaheadbrickball))
            {
                if (brickcount > 0)
                {
                    brickcount--;
                    shot = false;
                    sprite_index = spr_pizzahead_ratballthrow;
                    image_index = 0;
                }
                else
                {
                    sprite_index = spr_pizzahead_ratballend;
                    image_index = 0;
                }
            }
        }
    }
}

function boss_pizzahead_shotgun()
{
    switch (substate)
    {
        case states.mini:
            if (sprite_index == spr_pizzahead_grabgun)
            {
                if (floor(image_index) == (image_number - 1))
                    sprite_index = spr_pizzahead_machinegun;
            }
            else if (attackbuffer > 0)
            {
                attackbuffer--;
            }
            else
            {
                attackbuffer = 5;
                ammo--;
                
                if (ammo > 0)
                {
                    with (instance_create(x, y, obj_pizzaheadbullet))
                    {
                        image_angle = other.minigun_angle;
                        
                        if (other.image_xscale == -1)
                            image_angle *= -1;
                    }
                    
                    minigun_angle += (minigun_dir * 15);
                    
                    if (image_xscale > 0)
                    {
                        if (minigun_dir == -1 && minigun_angle < 120)
                            minigun_dir *= -1;
                        else if (minigun_dir == 1 && minigun_angle > 225)
                            minigun_dir *= -1;
                    }
                    else if (minigun_dir == -1 && minigun_angle < 315)
                    {
                        minigun_dir *= -1;
                    }
                    else if (minigun_dir == 1 && minigun_angle > 405)
                    {
                        minigun_dir *= -1;
                    }
                }
                else
                {
                    with (instance_create(x - (image_xscale * 30), y, obj_pizzaheadminigun))
                    {
                        image_xscale = other.image_xscale;
                        hsp = -image_xscale * 14;
                        vsp = -10;
                    }
                    
                    idle_buffer = 0;
                    substate = states.throwing;
                    sprite_index = spr_pizzahead_throwaway;
                    image_index = 0;
                    miniguncount = 2;
                    fishcount = 0;
                }
            }
            
            break;
        
        case states.throwing:
            if (floor(image_index) == (image_number - 1))
            {
                if (sprite_index == spr_pizzahead_grabbox)
                {
                    sprite_index = spr_pizzahead_throwaway;
                    image_index = 0;
                    idle_buffer = 0;
                    
                    with (instance_create(x, y - 15, obj_pistolpickup))
                    {
                        hsp = irandom_range(5, 10) * -other.image_xscale;
                        vsp = -irandom_range(7, 14);
                    }
                }
                else if (sprite_index == spr_pizzahead_grabdynamite)
                {
                    idle_buffer = 0;
                    sprite_index = spr_pizzahead_throwaway;
                    image_index = 0;
                    
                    repeat (5)
                    {
                        with (instance_create(x - (image_xscale * 5), y - 15, obj_vigilantedynamite))
                        {
                            hsp = irandom_range(5, 10) * -other.image_xscale;
                            vsp = -irandom_range(7, 14);
                        }
                    }
                }
                else
                {
                    state = states.walk;
                    
                    if (!global.pistol)
                    {
                        image_xscale = saveddir;
                        sprite_index = spr_pizzahead_idle;
                    }
                    else
                    {
                        if (miniguncount > 0)
                            fishcount = 0;
                        else
                            image_xscale = saveddir;
                        
                        if (miniguncount == 2)
                            image_xscale = saveddir;
                    }
                }
            }
            
            break;
    }
}

function boss_pizzahead_p2_phase1hurt()
{
    x = hitX + irandom_range(-1, 1);
    y = hitY + irandom_range(-1, 1);
    hsp = 0;
    vsp = 0;
    
    with (obj_player)
    {
        actorbuffer = 10000;
        hsp = 0;
        vsp = 0;
        invtime = 30;
        state = states.actor;
        pistolanim = -4;
        sprite_index = spr_player_pistolshotend;
    }
    
    instance_create_unique(0, 0, obj_bossdark);
    
    if (buildup > 0)
    {
        obj_camera.lock = true;
        camzoom = lerp(camzoom, 0.5, 0.2);
        camera_set_view_size(view_camera[0], obj_screensizer.actual_width * camzoom, obj_screensizer.actual_height * camzoom);
        var _x = clamp(x - ((obj_screensizer.actual_width * camzoom) / 2), 0, room_width - (obj_screensizer.actual_width * camzoom));
        var _y = clamp(y - ((obj_screensizer.actual_height * camzoom) / 2), 0, room_height - (obj_screensizer.actual_height * camzoom));
        camera_set_view_pos(view_camera[0], _x, _y);
        buildup--;
    }
    else
    {
        instance_destroy(obj_bossdark);
        instance_create(0, 0, obj_pizzahead_whitefade);
        obj_camera.lock = false;
        camzoom = 1;
        camera_set_view_size(view_camera[0], obj_screensizer.actual_width, obj_screensizer.actual_height);
        elitehit--;
        
        with (obj_player)
            state = states.normal;
    }
}
