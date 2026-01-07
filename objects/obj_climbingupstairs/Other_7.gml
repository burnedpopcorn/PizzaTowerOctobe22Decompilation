image_speed = 0;

if (!instance_exists(obj_fadeout))
{
    with (obj_player)
    {
        targetRoom = other.targetRoom;
        targetDoor = other.targetDoor;
        
        if (check_player_coop())
            state = states.door;
    }
    
    instance_create(0, 0, obj_fadeout);
}
