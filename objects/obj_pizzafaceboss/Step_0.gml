targetplayer = obj_player1.id;
wastedhits = 8 - elitehit;
destroyable = false;

switch (state)
{
    case states.arenaintro:
        scr_pizzaface_arenaintro();
        break;
    
    case states.walk:
        scr_pizzaface_normal();
        break;
    
    case states.pizzaface_ram:
        scr_pizzaface_ram();
        break;
    
    case states.transitioncutscene:
        scr_pizzaface_transitioncutscene();
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
    
    case states.pummel:
        scr_enemy_pummel();
        break;
    
    case states.staggered:
        scr_enemy_staggered();
        break;
}

if (state != states.walk)
    on_y = true;

if (wastedhits >= 8 && state == states.walk)
{
    with (obj_music)
        fmod_event_instance_set_parameter(music.event, "state", 1, true);
    
    state = states.transitioncutscene;
    substate = states.transitioncutscene;
    flickertime = 0;
    image_alpha = 1;
    
    with (obj_baddie)
    {
        if (object_index != obj_pizzafaceboss && object_index != obj_pizzafaceboss_p2)
            instance_destroy();
    }
}

if (prevhp != elitehit)
{
    if (elitehit < prevhp)
    {
        baddie_range++;
        cooldown = 30;
        touchedground = false;
        hsp += (-image_xscale * 5);
        flickertime = 11;
        alarm[6] = 5;
        playerhit++;
        
        if (playerhit >= 3)
        {
            playerhit = 0;
            instance_create(obj_player1.x, -15, obj_hppickup);
        }
    }
    
    prevhp = elitehit;
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
    savedthrown = false;

if (state == states.stun && stunned > 100 && birdcreated == false)
{
    birdcreated = true;
    
    with (instance_create(x, y, obj_enemybird))
        ID = other.id;
}

if (state == states.stun && savedthrown == thrown && !savedthrown)
    invincible = false;
else
    invincible = true;

if (!invincible && !flash && alarm[5] < 0)
    alarm[5] = 0.15 * room_speed;
else if (invincible)
    flash = false;

if (state == states.pizzaface_ram && alarm[4] < 0)
    alarm[4] = 6;

if (state == states.stun && thrown)
{
    while (place_meeting(x, y, obj_solid))
        y--;
}

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

mask_index = spr_pizzaface;
