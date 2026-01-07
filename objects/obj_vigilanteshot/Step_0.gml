x += (image_xscale * spd);

if (image_index > 7 && woosh)
{
    spd = 8;
    
    with (instance_create(x, y, obj_jumpdust))
    {
        image_xscale = other.image_xscale;
        var oy = y;
        
        while (!place_meeting(x, y + 1, obj_solid))
        {
            y++;
            
            if (y > room_height)
                y = oy;
        }
    }
    
    woosh = false;
}
