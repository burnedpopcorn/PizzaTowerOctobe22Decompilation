func = function(arg0)
{
    if (active == false && arg0.state == states.backbreaker)
    {
        active = true;
        obj_secretmanager.touchedtriggers += 1;
    }
};
