if (state != UnknownEnum.Value_145)
{
    wave_seconds--;
    
    if (wave_seconds < 0)
    {
        if (wave_minutes > 0)
        {
            wave_seconds = 59;
            wave_minutes--;
        }
        else
        {
            wave_seconds = 0;
            
            with (obj_player1)
            {
                if (state != states.ejected)
                {
                    vsp = -11;
                    state = states.ejected;
                    targetRoom = lastroom;
                }
            }
        }
    }
}

if (state == UnknownEnum.Value_143 || state == UnknownEnum.Value_142)
    alarm[0] = 60;
