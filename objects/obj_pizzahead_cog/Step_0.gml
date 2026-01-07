if (!landed)
    image_speed = 0;
else
    image_speed = 0.35;

if (grounded && vsp > 0)
{
    if (!landed)
    {
        landed = true;
        
        if (x != obj_player1.x)
            image_xscale = sign(obj_player1.x - x);
    }
    
    hsp = image_xscale * 4;
}

if (!landed)
    scr_collide();
else
    x += hsp;
