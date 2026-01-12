if (state == states.walk && formed)
{
    if (paletteselect == 0)
        paletteselect = 2;
    else
        paletteselect = 0;
}
else
    paletteselect = 0;

if (paletteselect == 0)
    alarm[8] = 10;
else
    alarm[8] = 5;
