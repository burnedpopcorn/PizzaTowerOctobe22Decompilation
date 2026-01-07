function cutscene_set_object_pos(arg0, arg1, arg2)
{
    with (arg0)
    {
        x = arg1;
        y = arg2;
    }
    
    cutscene_end_action();
}
