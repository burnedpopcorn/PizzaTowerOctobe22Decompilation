targetplayer = global.coop ? instance_nearest(x, y, obj_player) : obj_player1;

if (hp <= 0 && state != UnknownEnum.Value_145)
{
    if (!destroyed && !thrown && !destroyable)
        boss_destroy(lastplayerid);
}

switch (state)
{
    case UnknownEnum.Value_145:
        grav = 0.5;
        state_boss_arenaround();
        break;
    
    case states.normal:
        grav = 0.5;
        boss_mrstick_normal();
        break;
    
    case UnknownEnum.Value_174:
        grav = 0.5;
        boss_mrstick_shield();
        break;
    
    case UnknownEnum.Value_175:
        grav = 0.5;
        boss_mrstick_helicopterhat();
        break;
    
    case UnknownEnum.Value_176:
        grav = 0.5;
        boss_mrstick_panicjump();
        break;
    
    case states.jump:
        grav = 0.5;
        boss_mrstick_jump();
        break;
    
    case UnknownEnum.Value_177:
        grav = 0.5;
        boss_mrstick_smokebombstart();
        break;
    
    case UnknownEnum.Value_178:
        grav = 0.5;
        boss_mrstick_smokebombcrawl();
        break;
    
    case UnknownEnum.Value_179:
        grav = 0.5;
        boss_mrstick_springshoes();
        break;
    
    case UnknownEnum.Value_180:
        grav = 0.5;
        boss_mrstick_cardboard();
        break;
    
    case UnknownEnum.Value_181:
        grav = 0.5;
        boss_mrstick_cardboardend();
        break;
    
    case UnknownEnum.Value_182:
        grav = 0.5;
        boss_mrstick_mockery();
        break;
    
    case states.walk:
        grav = 0.5;
        state_boss_walk(boss_mrstick_decide_attack);
        inv_timer = 2;
        invincible = true;
        break;
    
    case states.chainsaw:
        grav = 0.5;
        state_boss_chainsaw();
        break;
    
    case states.backbreaker:
        grav = 0.5;
        state_boss_taunt();
        invincible = true;
        inv_timer = 2;
        break;
    
    case states.Parry:
        grav = 0.5;
        state_boss_parry();
        invincible = true;
        inv_timer = 2;
        break;
    
    case states.hit:
        grav = 0.5;
        scr_enemy_hit();
        stunned = targetstunned;
        break;
    
    case states.stun:
        grav = 0.5;
        state_boss_stun();
        break;
}

colliding = !(state == states.jump || state == UnknownEnum.Value_180 || state == UnknownEnum.Value_181);
attacking = state == UnknownEnum.Value_174 || state == states.jump || state == UnknownEnum.Value_180 || state == UnknownEnum.Value_181 || state == UnknownEnum.Value_177;
