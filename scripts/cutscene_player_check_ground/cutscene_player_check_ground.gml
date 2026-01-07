function cutscene_player_check_ground(arg0)
{
    var player = arg0;
    var finish = false;
    
    with (player)
    {
        if (grounded)
            finish = true;
    }
    
    if (finish)
        cutscene_end_action();
}
