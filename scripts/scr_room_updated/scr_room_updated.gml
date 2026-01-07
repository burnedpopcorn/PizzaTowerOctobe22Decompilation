// unused and broken
function scr_room_updated(arg0)
{
    if (arg0 == room || (room == live_blank_room && live_live_room == arg0))
    {
        with (obj_player)
        {
            hallway = savedhallway;
            hallwaydirection = savedhallwaydirection;
            vhallwaydirection = savedvhallwaydirection;
            verticalhallway = savedverticalhallway;
        }
        
        room_goto_live(arg0);
    }
}
