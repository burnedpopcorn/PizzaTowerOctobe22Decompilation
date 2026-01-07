function cutscene_set_player_visible(arg0)
{
    with (obj_player)
        visible = arg0;
    
    cutscene_end_action();
}
