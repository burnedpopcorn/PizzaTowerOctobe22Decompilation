if (state != states.grabbed && (other.state != states.handstandjump || invincible) && state != states.stun && (state == UnknownEnum.Value_141 || state == states.walk))
{
    if (other.flash)
        other.flash = false;
    
    scr_hurtplayer(other);
}
