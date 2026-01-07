with (baddieID)
{
    if (alarm[5] != -1 || state == states.punch)
    {
        var p = patroltimermax - patroltimer;
        
        if (state == states.punch)
            p++;
        
        var t = (p * spr_entrancepillarsecret) + other.patrolalert_index;
        draw_sprite(spr_patrolalert_number, t, x, y - 100);
    }
}
