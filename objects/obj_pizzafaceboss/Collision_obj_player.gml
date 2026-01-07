if (state == states.ram && substate == states.ram)
{
    if (other.flash)
        other.flash = false;
    
    scr_hurtplayer(other);
}
