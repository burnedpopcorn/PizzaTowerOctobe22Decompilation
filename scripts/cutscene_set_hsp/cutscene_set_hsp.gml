function cutscene_set_hsp(_obj, _hsp)
{
    with (_obj)
        hsp = _hsp;
    
    cutscene_end_action();
}

function cutscene_set_vsp(_obj, _vsp)
{
    with (_obj)
        vsp = _vsp;
    
    cutscene_end_action();
}
