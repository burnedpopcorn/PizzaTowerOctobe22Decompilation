if (state == states.pizzaface_ram && substate == states.pizzaface_ram)
{
    if (other.flash)
        other.flash = false;
    
    scr_hurtplayer(other);
}
