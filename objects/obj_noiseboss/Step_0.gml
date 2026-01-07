if (room == rm_editor)
    exit;

targetplayer = obj_player1.id;
wastedhits = 8 - elitehit;

if (elitehit <= 1)
    destroyable = true;

switch (state)
{
    case states.arenaintro:
        scr_noise_arenaintro();
        break;
    
    case states.walk:
        scr_noise_walk();
        break;
    
    case states.mach2:
        scr_noise_mach2();
        break;
    
    case states.machslide:
        scr_noise_machslide();
        break;
    
    case states.jump:
        scr_noise_jump();
        break;
    
    case states.jetpackstart:
        scr_noise_jetpackstart();
        break;
    
    case states.jetpack:
        scr_noise_jetpack();
        break;
    
    case states.bounce:
        scr_noise_bounce();
        break;
    
    case states.pogo:
        scr_noise_pogo();
        break;
    
    case states.dropstart:
        scr_noise_dropstart();
        break;
    
    case states.drop:
        scr_noise_drop();
        break;
    
    case states.droptrap:
        scr_noise_droptrap();
        break;
    
    case states.golf:
        scr_noise_golf();
        break;
    
    case states.freefall:
        scr_noise_freefall();
        break;
    
    case states.noisecrusher:
        scr_noise_noisecrusher();
        break;
    
    case states.spin:
        scr_noise_spin();
        break;
    
    case states.noiseballooncrash:
        scr_noise_noiseballooncrash();
        break;
    
    case states.phase1hurt:
        scr_noise_phase1hurt();
        break;
    
    case states.fightball:
        scr_noise_fightball();
        break;
    
    case states.punch:
        scr_vigilante_punch();
        break;
    
    case states.pizzaheadKO:
        scr_boss_pizzaheadKO();
        break;
    
    case states.hit:
        scr_enemy_hit();
        break;
    
    case states.stun:
        scr_enemy_stun();
        break;
    
    case states.grabbed:
        scr_boss_grabbed();
        break;
    
    case states.pizzaheadjump:
        scr_boss_pizzaheadjump();
        break;
    
    case states.pummel:
        scr_enemy_pummel();
        break;
    
    case states.staggered:
        scr_enemy_staggered();
        break;
}

boss_update_pizzaheadKO(spr_bossfight_noiseHP, spr_bossfight_noisepalette);

with (obj_noisey)
{
    var t = id;
    
    if (thrown && (place_meeting(x + hsp, y, other) || place_meeting(x, y, other)))
    {
        with (other)
            scr_noise_do_hurt(t);
    }
}

if (pizzahead)
{
    with (obj_gustavograbbable)
    {
        var t = id;
        
        if (thrown && other.state != states.pizzaheadKO && (place_meeting(x + hsp, y, other) || place_meeting(x, y, other)))
        {
            with (other)
                scr_noise_do_hurt(t);
        }
    }
}

if (droptrap && (state == states.walk || state == states.stun))
{
    if (abs(x - targetplayer.x) <= 200)
    {
        droptrap = false;
        state = states.droptrap;
        sprite_index = spr_noise_copyexplode;
        image_index = 0;
    }
}

if (wastedhits >= 8 && phase == 1 && !pizzahead)
{
    elitehit = 8;
    wastedhits = 0;
    phase = 2;
    ballooncrash = true;
    flickertime = 0;
    cooldown = 20;
    avaiblemoves = [];
    skateboardhit = 0;
    jetpackhit = 0;
    pogohit = 0;
    hotairhit = 0;
    destroyable = true;
    scr_sleep(25);
}

if (state == states.stun)
{
    if (thrown)
        savedthrown = true;
    
    if (grounded && vsp > 0 && savedthrown)
    {
        stunned = 1;
        idle_timer = 1;
    }
}
else
{
    savedthrown = false;
}

if (prevhp != elitehit)
{
    if (elitehit < prevhp)
    {
        avaiblemoves = [];
        
        if (lastattack == 0)
            skateboardhit += 1;
        
        if (lastattack == 1)
            jetpackhit += 1;
        
        if (lastattack == 2)
            pogohit += 1;
        
        if (lastattack == 3)
            hotairhit += 1;
        
        boss_do_pizzaheadKO();
        
        if (pizzahead && elitehit <= 2 && !pizzaheadshot)
            pizzaheadshot = true;
        
        cooldown = 0;
        touchedground = false;
        hsp += (-image_xscale * 5);
        flickertime = 11;
        alarm[6] = 5;
        playerhit++;
        pogobomb = false;
        
        if (playerhit >= 3)
        {
            playerhit = 0;
            instance_create(obj_player1.x, -32, obj_hppickup);
        }
    }
    
    prevhp = elitehit;
}

if (state == states.stun && stunned > 100 && birdcreated == false)
{
    birdcreated = true;
    
    with (instance_create(x, y, obj_enemybird))
        ID = other.id;
}

if ((state == states.walk || (state == states.stun && !savedthrown)) && flickertime <= 0 && (wastedhits != 7 || phase != 1 || pizzahead))
    invincible = false;
else
    invincible = true;

if (instance_exists(obj_noiseballooncrash))
    invincible = true;

if (state == states.pizzaheadKO)
    invincible = true;

if (place_meeting(x, y, obj_player) && !invincible && state != states.phase1hurt && state != states.fightball && (state != states.walk || !droptrap) && !instance_exists(obj_noiseballooncrash) && grounded && vsp > 0 && !obj_player1.hurted)
{
    if (obj_player1.flash)
        obj_player1.flash = false;
    
    scr_hurtplayer(464);
    tauntstoredsprite = sprite_index;
    tauntstoredindex = image_index;
    tauntstoredstate = state;
    state = states.punch;
    sprite_index = spr_playerN_spin;
    image_index = 0;
}

if ((!invincible || ((state == states.walk && flickertime <= 0) || (state == states.stun && !savedthrown))) && !flash && alarm[5] < 0)
    alarm[5] = 0.15 * room_speed;
else if (invincible && (state != states.walk || flickertime > 0) && (state != states.stun || savedthrown))
    flash = false;

if ((state == states.mach2 || state == states.machslide || state == states.jetpack || state == states.bounce || state == states.pogo) && alarm[4] < 0)
    alarm[4] = 5;

mask_index = spr_player_mask;

if (state != states.stun)
    birdcreated = false;

if (flash == true && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (state != states.grabbed)
    depth = 0;

if (state != states.stun)
    thrown = false;

if (boundbox == false)
{
    with (instance_create(x, y, obj_baddiecollisionbox))
    {
        sprite_index = other.sprite_index;
        mask_index = other.sprite_index;
        baddieID = other.id;
        other.boundbox = true;
    }
}
