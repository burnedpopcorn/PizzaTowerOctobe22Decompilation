function cutscene_set_sprite(arg0, arg1, arg2, arg3)
{
    var _obj = arg0;
    var _spr = arg1;
    var _spd = arg2;
    var _xscale = arg3;
    
    with (_obj)
    {
        sprite_index = _spr;
        image_speed = _spd;
        image_xscale = _xscale;
        image_index = 0;
        xscale = _xscale;
    }
    
    cutscene_end_action();
}
