function scr_pizzaface_p3_do_player_attack(arg0)
{
    with (arg0)
    {
        state = states.supergrab;
        substate = states.grab;
        attackcooldown = 0;
        baddieID = other.id;
        image_index = 0;
        randomize_animations([spr_suplexmash1, spr_suplexmash2, spr_suplexmash3, spr_suplexmash4, spr_player_suplexmash5, spr_player_suplexmash6, spr_player_suplexmash7, spr_punch]);
        punchcount = 20;
    }
    
    hsp = 0;
    image_xscale = -arg0.xscale;
    playerid = arg0;
    state = states.supergrab;
    substate = states.grabbed;
}

function scr_pizzaface_p3_arenaintro()
{
    with (obj_player1)
    {
        if (ANIMATION_END && sprite_index == spr_player_levelcomplete)
            sprite_index = spr_idle;
    }
    
    switch (introstate)
    {
        case states.arenaintro:
            hsp = 0;
            vsp = 0;
            obj_player1.hsp = 0;
            
            if (ANIMATION_END)
            {
                image_index = image_number - 1;
                introstate = states.idle;
                introbuffer = 80;
                
                with (obj_player1)
                {
                    if (x != other.x)
                        xscale = sign(other.x - x);
                    
                    state = states.actor;
                    sprite_index = spr_player_levelcomplete;
                    image_index = 0;
                }
            }
            
            break;
        
        case states.idle:
            image_index = image_number - 1;
            
            if (obj_player1.sprite_index != obj_player1.spr_victory)
            {
                if (introbuffer > 0)
                {
                    introbuffer--;
                }
                else if (elitehit < maxhp)
                {
                    elitehit++;
                    introbuffer = 10;
                }
                else
                {
                    sprite_index = spr_pizzahead_phase3_intro2;
                    image_index = 0;
                    introstate = states.jump;
                }
            }
            
            break;
        
        case states.jump:
            if (floor(image_index) >= 50)
            {
                if (x != obj_player1.x)
                    image_xscale = sign(obj_player1.x - x);
            }
            
            if (ANIMATION_END)
            {
                if (sprite_index == spr_pizzahead_phase3_intro2)
                    image_index = image_number - 1;
                else
                    image_index = image_number - 3;
                
                with (obj_player1)
                {
                    if (sprite_index == spr_idle)
                    {
                        sprite_index = spr_gustavo_poweringup;
                        image_index = 0;
                    }
                    
                    if (sprite_index == spr_gustavo_poweringup && ANIMATION_END)
                    {
                        sprite_index = spr_gustavo_grab;
                        other.sprite_index = spr_pizzahead_phase3_intro3;
                        other.image_index = 0;
                    }
                }
            }
            
            with (obj_player1)
            {
                if (sprite_index == spr_gustavo_grab)
                {
                    hsp = xscale * 12;
                    
                    if (abs(x - other.x) <= 50)
                    {
                        with (other)
                            scr_pizzaface_p3_do_player_attack(obj_player1);
                    }
                }
            }
            
            break;
    }
}

function scr_pizzaface_p3_fall()
{
    if (grounded && vsp > 0)
        state = states.walk;
}

function scr_pizzaface_p3_walk()
{
    if (flickertime <= 0)
    {
        image_speed = 0.35;
        sprite_index = spr_pizzahead_phase3idle;
        var ix = sign(targetplayer.x - x);
        hsp = Approach(hsp, 0, 0.5);
        
        if (ix != 0)
            image_xscale = ix;
        
        if (cooldown > 0)
        {
            cooldown--;
        }
        else
        {
            cooldown = 100 - (wastedhits * 5);
            
            do
                state = choose(states.punch, states.stomp, states.swinging);
            until (state != lastattack);
            
            lastattack = state;
            
            switch (state)
            {
                case states.swinging:
                    image_xscale = (x > (room_width / 2)) ? -1 : 1;
                    sprite_index = spr_pizzahead_swingingstart;
                    image_index = 0;
                    attackspeed = 0;
                    break;
                
                case states.punch:
                    sprite_index = spr_pizzahead_bigpunch;
                    image_index = 0;
                    instance_destroy(hitboxID);
                    hitboxID = -4;
                    break;
                
                case states.stomp:
                    sprite_index = spr_pizzahead_stomp;
                    image_index = 0;
                    shot = false;
                    break;
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

function scr_pizzaface_p3_stomp()
{
    hsp = 0;
    
    if (floor(image_index) >= 20 && !shot)
    {
        shot = true;
        
        with (instance_create(x + (image_xscale * 118), y + 33, obj_pizzaheadstomp))
            image_xscale = 1;
        
        with (instance_create(x + (image_xscale * 118), y + 33, obj_pizzaheadstomp))
            image_xscale = -1;
    }
    
    if (ANIMATION_END)
        state = states.walk;
}

function scr_pizzaface_p3_punch()
{
    hsp = 0;
    
    if (floor(image_index) >= 17 && hitboxID == -4)
    {
        with (instance_create(x, y, obj_forkhitbox))
        {
            sprite_index = spr_pizzahead_bigpunch;
            ID = other.id;
            other.hitboxID = id;
        }
    }
    
    if (ANIMATION_END)
        state = states.walk;
    
    hsp = 0;
}

function scr_pizzaface_p3_swinging()
{
    if (sprite_index == spr_pizzahead_swingingstart)
    {
        hsp = 0;
        
        if (ANIMATION_END)
        {
            hitboxID = instance_create(x, y, obj_forkhitbox);
            hitboxID.ID = id;
            hitboxID.sprite_index = spr_pizzahead_swinging;
            sprite_index = spr_pizzahead_swinging;
        }
    }
    else
    {
        hsp = image_xscale * attackspeed;
        
        if (attackspeed < 10)
            attackspeed += 0.5;
        
        if (place_meeting(x + hsp, y, obj_solid))
            state = states.walk;
    }
}

function scr_pizzaface_p3_throwing()
{
    hsp = 0;
    
    if (!place_meeting(x, y, obj_pizzaheadgetout))
    {
        if (getoutbuffer > 0)
            getoutbuffer--;
        else
            state = states.walk;
    }
}

function scr_pizzaface_p3_staggered()
{
    hsp = Approach(hsp, 0, 0.1);
    
    if (cooldown > 0)
        cooldown--;
    
    if (abs(hsp) == 0)
        state = states.walk;
}

function scr_pizzaface_p3_handstandjump()
{
    sprite_index = spr_pizzahead_bigkickstart;
    hsp = image_xscale * (10 + wastedhits);
    
    if (attackcooldown > 0)
        attackcooldown--;
    else
        state = states.normal;
}

function scr_pizzaface_p3_jump()
{
    if (scr_solid(x, y + vsp) && !scr_solid(x, y) && vsp > 0)
    {
        state = states.normal;
        cooldown = 1;
    }
}

function scr_pizzaface_p3_supergrab()
{
    hsp = Approach(hsp, 0, 0.5);
    sprite_index = spr_pizzahead_hurt;
    
    with (playerid)
    {
        image_speed = 1.2;
        
        if (state == states.supergrab)
        {
            switch (substate)
            {
                case states.grab:
                    hsp = 0;
                    vsp = 0;
                    x = other.x + (other.image_xscale * 12);
                    y = other.y;
                    
                    if (ANIMATION_END)
                    {
                        if (punchcount > 0)
                        {
                            other.hsp = -other.image_xscale * 6;
                            punchcount--;
                            image_index = 0;
                            randomize_animations([spr_suplexmash1, spr_suplexmash2, spr_suplexmash3, spr_suplexmash4, spr_player_suplexmash5, spr_player_suplexmash6, spr_player_suplexmash7, spr_punch]);
                        }
                        else if (other.elitehit > 1)
                        {
                            sprite_index = choose(spr_finishingblow1, spr_finishingblow2, spr_finishingblow3, spr_finishingblow4, spr_finishingblow4, spr_finishingblow5);
                            substate = states.finishingblow;
                            shot = false;
                        }
                        else
                        {
                            other.state = states.finale;
                            state = states.finale;
                            other.finale_x = x + ((other.x - x) / 2);
                        }
                    }
                    
                    break;
                
                case states.finishingblow:
                    if (floor(image_index) >= 3 && !shot)
                    {
                        fmod_event_one_shot_3d("event:/sfx/pep/punch", x, y);
                        shot = true;
                        
                        with (other)
                        {
                            hitX = x;
                            hitY = y;
                            hithsp = -image_xscale * 25;
                            hitvsp = -5;
                            linethrown = true;
                            state = states.hit;
                            hitLag = 1;
                        }
                    }
                    
                    break;
            }
        }
    }
}

function scr_pizzaface_p3_finale()
{
    hsp = 0;
    vsp = 0;
    x = -200;
    y = -200;
    obj_player1.x = -200;
    obj_player1.y = -200;
    obj_player1.hsp = 0;
    obj_player1.vsp = 0;
}
