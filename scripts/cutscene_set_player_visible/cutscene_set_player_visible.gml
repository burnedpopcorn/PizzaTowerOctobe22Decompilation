function cutscene_set_player_visible(_vis)
{
    with (obj_player)
        visible = _vis;
    
    cutscene_end_action();
}
