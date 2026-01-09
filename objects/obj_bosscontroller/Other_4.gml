boss_maxhp = boss_hp;
boss_prevhp = boss_maxhp;
player_maxhp = player_hp;

if (boss_func != -4)
    boss_func();

boss_prevhp = boss_hp;
playerx = -sprite_get_width(playerspr);
bossx = SCREEN_WIDTH + sprite_get_width(bossspr);
instance_destroy(obj_pigtotal);
