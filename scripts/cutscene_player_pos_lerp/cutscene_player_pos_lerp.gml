function cutscene_player_pos_lerp(arg0, arg1, arg2)
{
    var _finish = false;
    
    with (obj_player)
    {
        hsp = 0;
        vsp = 0;
        
        if (object_index != obj_player2 || global.coop)
        {
            x = lerp(x, arg0, arg2);
            y = lerp(y, arg1, arg2);
            
            if (x > (arg0 - 4) && x < (x + 4) && y > (arg1 - 4) && y < (arg1 + 4))
                _finish = true;
        }
    }
    
    if (_finish)
        cutscene_end_action();
}
