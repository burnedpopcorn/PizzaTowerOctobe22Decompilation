func = function(arg0)
{
    if (!active && arg0.state == states.handstandjump)
    {
        active = true;
        obj_secretmanager.hittriggers++;
        
        with (arg0)
            scr_pummel();
    }
};
