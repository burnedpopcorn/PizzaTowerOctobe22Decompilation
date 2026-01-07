event_inherited();
dmg = 30;
spd = 25;
parryable = true;

function player_hurt(arg0, arg1)
{
    if (!collisioned)
    {
        var prevstate = arg1.state;
        SUPER_player_hurt(arg0, arg1);
        arg1.xscale = -image_xscale;
        arg1.hitxscale = -image_xscale;
        
        if (prevstate == UnknownEnum.Value_160)
        {
            arg1.hithsp = 0;
            arg1.hitvsp = 0;
            arg1.hitstate = UnknownEnum.Value_160;
            
            with (obj_vigilanteboss)
                duel_buffer = duel_max + irandom(duel_random);
        }
    }
}

function parry()
{
    var prevparried = parried;
    SUPER_parry();
    
    if (prevparried != parried)
    {
        image_xscale *= -1;
        dmg = 100;
        spd = 30;
    }
}
