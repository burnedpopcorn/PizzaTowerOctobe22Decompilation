function cutscene_change_room(arg0)
{
    with (obj_player)
        targetRoom = arg0;
    
    instance_create(x, y, obj_fadeout);
    
    if (room == arg0)
        cutscene_end_action();
}
