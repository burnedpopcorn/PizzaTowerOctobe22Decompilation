function scr_boss_grabbed()
{
    if (pizzahead)
    {
        instance_destroy(obj_peppermanGIANTbowlingball);
        instance_destroy(obj_peppermanartdude);
        instance_destroy(obj_peppermanbowlingball);
        instance_destroy(obj_peppermanbowlingballspawner);
        instance_destroy(obj_vigilantecow);
        instance_destroy(obj_cowstampede);
        instance_destroy(obj_vigilanteshot);
    }
    
    var playerid = (grabbedby == 1) ? obj_player1.id : obj_player2.id;
    
    with (playerid)
    {
        if (state != states.supergrab || baddiegrabbedID != other.id)
        {
            if (other.elitehit <= 1 && other.object_index != obj_pizzafaceboss)
                other.destroyable = true;
            
            punchcount = 20 - (other.elitehit * 3);
            pizzahead = other.pizzahead;
            
            if (!other.pizzahead)
                punchcount = 0;
            
            camzoom = other.camzoom;
            baddiegrabbedID = other.id;
            state = states.supergrab;
            supergrabstate = states.punch;
            other.camzoom = 1;
        }
    }
    
    image_xscale = -playerid.xscale;
    sprite_index = grabbedspr;
    state = states.supergrab;
}

function scr_boss_pizzaheadjump()
{
    if (object_index != obj_noisey)
        hsp = 0;
    
    if (vsp < 0)
    {
        use_collision = false;
        x += hsp;
        y += vsp;
        
        if (vsp < 20)
            vsp += grav;
    }
    else
        use_collision = true;
    
    if (ANIMATION_ENDED)
    {
        switch (sprite_index)
        {
            case spr_playerV_jump:
                sprite_index = spr_playerV_fall;
                break;
            
            case spr_lonegustavo_jumpstart:
                sprite_index = spr_lonegustavo_jump;
                break;
            
            case spr_playerN_jump:
                sprite_index = spr_playerN_fall;
                break;
            
            case spr_fakepeppino_jump:
                sprite_index = spr_fakepeppino_fall;
                break;
        }
    }
    
    if (grounded && vsp > 0)
    {
        state = states.walk;
        
        if (object_index == obj_noisey)
        {
            state = states.stun;
            stunned = 100;
        }
    }
}

function boss_update_pizzaheadKO(_HPsprite, _palette)
{
    if (pizzahead && pizzaheadKO && !instance_exists(pizzaheadKO_ID))
    {
        pizzaheadKO = false;
        elitehit = 4;
        prevhp = elitehit;
        
        with (obj_bosscontroller)
        {
            boss_hpsprite = _HPsprite;
            boss_palette = _palette;
        }
        
        image_alpha = 1;
        
        if (state == states.pizzaheadKO)
            state = states.walk;
    }
}

function boss_hurt_gustavo()
{
    if (pizzahead)
    {
        with (obj_gustavograbbable)
        {
            if (thrown && other.state != states.pizzaheadKO && (place_meeting(x + hsp, y, other) || place_meeting(x - image_xscale, y, other) || place_meeting(x - (32 * image_xscale), y, other) || place_meeting(x + (32 * image_xscale), y, other)))
            {
                with (other)
                {
                    state = states.stun;
                    stunned = 1000;
                    thrown = false;
                    hsp = -image_xscale * 8;
                    vsp = -4;
                    instance_destroy(other);
                }
            }
        }
    }
}

function boss_do_pizzaheadKO()
{
    if (pizzahead && pizzaheadKO && state != states.pizzaheadjump && elitehit <= 3)
    {
        pizzaheadKO_buffer = 5;
        state = states.pizzaheadKO;
        image_alpha = 1;
    }
}

function scr_boss_pizzaheadKO()
{
    if (grounded)
        hsp = Approach(hsp, 0, 0.2);
    
    switch (object_index)
    {
        case obj_vigilanteboss:
            sprite_index = spr_playerV_hurt;
            break;
        
        case obj_noiseboss:
            sprite_index = spr_playerN_hurt;
            break;
        
        case obj_fakepepboss:
            sprite_index = spr_fakepeppino_vulnerable;
            break;
    }
    
    if (pizzaheadKO_buffer > 0)
        pizzaheadKO_buffer = 0;
    else
    {
        pizzaheadKO_buffer = 5;
        
        if (image_alpha == 1)
            image_alpha = 0;
        else
            image_alpha = 1;
    }
}

function scr_boss_do_hurt_phase2(_playerID, _inv_time = 80)
{
    with (_playerID)
    {
        state = states.phase1hurt;
        invtime = _inv_time + 40;
        sprite_index = spr_finishingblow1;
        image_index = 0;
        hitX = x;
        hitY = y;
    }
    
    pulse = 0;
    state = states.phase1hurt;
    buildup = _inv_time;
    buildup_playerID = _playerID;
    camzoom = 1;
    image_xscale = -_playerID.xscale;
    instance_create(0, 0, obj_bossdark);
}

function scr_boss_phase1hurt(_func = noone)
{
    var player = buildup_playerID;
    var px = player.x + (player.xscale * 60);
    var py = player.y;
    
    if (buildup > 0)
    {
        camzoom = lerp(camzoom, 0.5, 0.1);
        camera_set_view_size(view_camera[0], SCREEN_WIDTH * camzoom, SCREEN_HEIGHT * camzoom);
        x = px;
        y = py;
        buildup--;
        
        with (player)
        {
            invtime = 30;
            vsp = 0;
            x = hitX;
            y = hitY;
            image_index = 0;
            image_speed = 0.35;
            
            if (other.pulse > 0)
                other.pulse--;
            else
            {
                other.pulse = 10;
                
                with (create_blur_afterimage(x + irandom_range(-4, 4), y + irandom_range(-4, 4), sprite_index, image_index, xscale))
                    playerid = other.id;
            }
        }
    }
    else
    {
        camzoom = lerp(camzoom, 1, 0.5);
        camera_set_view_size(view_camera[0], SCREEN_WIDTH * camzoom, SCREEN_HEIGHT * camzoom);
        
        with (player)
        {
            if (state != states.finishingblow)
            {
                state = states.finishingblow;
                image_index = 0;
                hsp = 0;
                movespeed = 0;
            }
        }
        
        x = px;
        y = py;
        
        if (floor(player.image_index >= 4))
        {
            var lag = 15;
            hitLag = lag;
            hitX = x;
            hitY = y;
            player.movespeed = 0;
            player.hitLag = lag;
            player.hitX = player.x;
            player.hitY = player.y;
            instance_create(x, y, obj_parryeffect);
            state = states.stun;
            image_xscale = -player.xscale;
            instance_create(x, y, obj_slapstar);
            instance_create(x, y, obj_slapstar);
            instance_create(x, y, obj_slapstar);
            instance_create(x, y, obj_baddiegibs);
            instance_create(x, y, obj_baddiegibs);
            instance_create(x, y, obj_baddiegibs);
            instance_create(x, y, obj_bangeffect);
            instance_destroy(obj_bossdark);
            
            repeat (4)
            {
                with (create_debris(x + random_range(-64, 64), y + random_range(-64, 64), spr_flashdots, true))
                {
                    hsp = random_range(-5, 5);
                    vsp = random_range(-10, 10);
                    image_speed = 0.4;
                }
            }
            
            camera_set_view_size(view_camera[0], SCREEN_WIDTH, SCREEN_HEIGHT);
            create_heatattack_afterimage(x, y, sprite_index, image_index, image_xscale);
            
            with (obj_camera)
            {
                shake_mag = 3;
                shake_mag_acc = 5 / room_speed;
            }
            
            with (player)
            {
                other.hithsp = -other.image_xscale * 25;
                other.hitvsp = -8;
                vsp = -6;
            }
            
            check_grabbed_solid(player);
            check_grabbed_solid(player);
            hsp = hithsp;
            vsp = hitvsp;
            thrown = true;
            linethrown = true;
            
            if (_func != noone)
                _func();
        }
    }
}
