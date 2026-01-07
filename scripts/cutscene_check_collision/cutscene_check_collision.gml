function cutscene_check_collision(arg0, arg1)
{
    var obj1 = arg0;
    var obj2 = arg1;
    var finish = false;
    
    with (obj1)
    {
        if (place_meeting(x, y, obj2))
            finish = true;
    }
    
    if (finish)
        cutscene_end_action();
}
