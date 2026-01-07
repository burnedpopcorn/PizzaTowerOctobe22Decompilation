switch (state)
{
    case states.arenaintro:
        scr_bosscontroller_intro();
        break;
    
    case states.normal:
        scr_bosscontroller_normal();
        break;
    
    case states.victory:
        scr_bosscontroller_victory();
        break;
}

if (!round_timer_init)
{
    round_timer = round_timermax;
    round_timer_init = true;
}

player_index += 0.35;
boss_index += 0.35;

if (player_index >= (sprite_get_number(spr_bossfight_playerhp) - 1))
    player_index = frac(player_index);

if (boss_index >= (sprite_get_number(boss_hpsprite) - 1))
    boss_index = frac(boss_index);
