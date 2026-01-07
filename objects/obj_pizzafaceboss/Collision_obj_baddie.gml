if (other.thrown && flickertime <= 0 && on_y)
{
    state = states.stun;
    stunned = 1000;
    thrown = false;
    image_xscale = other.image_xscale;
    hsp = -image_xscale * 8;
    vsp = -4;
    
    with (other)
    {
        state = states.stun;
        thrown = true;
        linethrown = false;
        image_xscale *= -1;
        hsp = -image_xscale * 5;
        hp = 0;
        hithsp = hsp;
    }
}
