bossspr = 3046;
boss_hp = 20;
vstitle = spr_vstitle_vigilante;
boss_hpsprite = spr_bossfight_vigiHP;
boss_palette = spr_bossfight_vigipalette;

boss_func = function()
{
    var eh = 0;
    var p = -1;
    
    with (obj_vigilanteboss)
    {
        eh = elitehit;
        p = phase;
    }
    
    if (p == 1)
        boss_hp = 9 + eh + 1;
    else if (p == 2)
        boss_hp = eh + 1;
    else if (p == -1)
        boss_hp = 0;
};
