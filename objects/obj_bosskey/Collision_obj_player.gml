if (state == states.normal)
{
    with (other)
    {
        state = states.gottreasure;
        sprite_index = spr_gottreasure;
    }
    
    state = states.gottreasure;
    x = other.x;
    y = other.y - 50;
    
    if (!instance_exists(obj_bosscontroller))
        alarm[0] = 150;
    
    with (obj_bosscontroller)
    {
        state = states.victory;
        
        with (obj_hpeffect)
            spd = 16;
    }
    
    if (room == boss_noise)
    {
        noisex = x;
        
        with (instance_create(x + 165, 544, obj_bosskeynoise))
        {
            hsp = -6;
            vsp = -15;
            image_xscale = -1;
        }
    }
    
    ini_open_from_string(obj_savesystem.ini_str);
    ini_write_real(save, "bosskey", true);
    obj_savesystem.ini_str = ini_close();
}
