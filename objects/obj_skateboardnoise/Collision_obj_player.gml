if (playerid == noone)
{
    playerid = other.id;
    other.state = states.skateboardnoise;
    other.hsp = 0;
    other.vsp = 0;
}
