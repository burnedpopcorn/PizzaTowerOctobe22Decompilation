event_inherited();
dmg = 10;
col_buffer = 0;
col_max = 10;

function player_hurt(arg0, arg1)
{
    if (!collisioned && arg1.state != UnknownEnum.Value_145)
    {
        col_buffer = col_max;
        SUPER_player_hurt(arg0, arg1);
    }
}
