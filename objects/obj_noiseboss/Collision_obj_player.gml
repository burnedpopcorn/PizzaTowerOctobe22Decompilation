if ((state == states.mach2 && hsp != 0) || (state == states.spin && image_index > 3) || (state == states.freefall && !grounded) || state == states.machslide || state == states.pogo || state == states.jetpack || state == states.bounce)
{
    if (other.flash)
        other.flash = false;
    
    scr_hurtplayer(other);
}
else if (((state == states.walk || (state == states.stun && savedthrown == thrown && !savedthrown)) && wastedhits == 7 && phase == 1 && (other.instakillmove || other.state == states.handstandjump)) && !pizzahead)
{
    scr_boss_do_hurt_phase2(other, 100);
}
