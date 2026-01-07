function cutscene_set_hsp(arg0, arg1)
{
    var _obj = arg0;
    var _hsp = arg1;
    
    with (_obj)
        hsp = _hsp;
    
    cutscene_end_action();
}

function cutscene_set_vsp(arg0, arg1)
{
    with (arg0)
        vsp = arg1;
    
    cutscene_end_action();
}
