if (state == states.normal)
{
    hsp = 0;
    state = states.idle;
    alarm[0] = 80 + irandom(110);
}
else
{
    image_xscale *= -1;
    hsp = 0;
    state = states.normal;
    alarm[0] = 60 + irandom(130);
}
