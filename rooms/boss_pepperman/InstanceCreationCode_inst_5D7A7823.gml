bossspr = 3510;
boss_hp = 20;
vstitle = spr_vstitle_pepperman;

boss_func = function()
{
    var eh = 0;
    var p = 0;
    
    with (obj_pepperman)
    {
        eh = elitehit;
        p = phase;
    }
    
    if (p == 1)
    {
        boss_hp = 11 + eh;
    }
    else if (p == 2)
    {
        boss_hp = eh + 1;
        
        if (eh <= 0)
            boss_hp = 1;
    }
    else if (p == 0)
    {
        boss_hp = 0;
    }
};
