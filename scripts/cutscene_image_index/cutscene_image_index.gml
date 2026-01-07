function cutscene_image_index(arg0, arg1)
{
    var _obj = arg0;
    var _index = arg1;
    
    with (_obj)
        image_index = _index;
    
    cutscene_end_action();
}
