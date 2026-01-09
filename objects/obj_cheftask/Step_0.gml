if (!finish)
{
    var ty = SCREEN_HEIGHT - 140;
    y = Approach(y, ty, movespeed);
    
    if (abs(ty - y) <= 100)
        movespeed = Approach(movespeed, 1, 0.1);
    
    if (abs(ty - y) <= 16)
    {
        y = ty;
        
        if (alarm[0] == -1)
            alarm[0] = 100;
    }
}
else
{
    var ty = SCREEN_HEIGHT + 200;
    y = Approach(y, ty, movespeed);
    movespeed = Approach(movespeed, 8, 0.1);
    
    if (y == ty)
        instance_destroy();
}
