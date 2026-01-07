bossspr = 3543;
boss_hp = 10;
vstitle = spr_vstitle_fakepep;
boss_hpsprite = spr_bossfight_fakepephp;
boss_palette = spr_bossfight_fakepeppalette;

boss_func = function()
{
    var eh = 0;
    var p = 0;
    
    with (obj_fakepepboss)
    {
        eh = elitehit;
        p = phase;
    }
    
    if (p == 1)
    {
        boss_hp = 7 + eh;
    }
    else if (p == 2)
    {
        boss_hp = eh + 1;
    }
    else if (p == 0)
    {
        boss_hp = 0;
        
        if (room == boss_fakepephallway)
            boss_hp = 1;
    }
};
