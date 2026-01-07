function cutscene_move_actor(arg0, arg1, arg2, arg3)
{
    var _obj = arg0;
    var xx = arg1;
    var yy = arg2;
    var interp = arg3;
    var finish = false;
    
    with (_obj)
    {
        x = lerp(x, xx, interp);
        y = lerp(y, yy, interp);
        
        if (x > (xx - 6) && x < (xx + 6) && y > (yy - 6) && y < (yy + 6))
            finish = true;
    }
    
    if (finish)
        cutscene_end_action();
}
