function cutscene_instance_create(arg0, arg1, arg2, arg3)
{
    var _obj = arg0;
    var xx = arg1;
    var yy = arg2;
    var _xscale = arg3;
    
    with (instance_create(xx, yy, _obj))
    {
        depth = other.depth;
        image_xscale = _xscale;
        xscale = _xscale;
    }
    
    cutscene_end_action();
}
