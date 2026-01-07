if (use_collision)
{
    if (!start)
    {
        sprite_index = stunspr;
        
        if (grounded && vsp > 0)
        {
            hsp = 0;
            start = true;
        }
    }
    else
    {
        hsp = Approach(hsp, 0, 0.1);
        sprite_index = angryspr;
    }
    
    scr_collide();
}
else
{
    x += hsp;
    y += vsp;
    
    if (vsp < 20)
        vsp += grav;
    
    if (y > 400)
        instance_destroy();
}
