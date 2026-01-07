function cutscene_customer_create(arg0, arg1, arg2, arg3, arg4)
{
    var xx = arg0;
    var yy = arg1;
    var _idle = arg2;
    var _happy = arg3;
    var _xscale = arg4;
    
    with (instance_create(xx, yy, obj_customeractor))
    {
        image_xscale = _xscale;
        depth = other.depth - 1;
        sprite_index = _idle;
        spr_idle = _idle;
        spr_happy = _happy;
    }
    
    cutscene_end_action();
}
