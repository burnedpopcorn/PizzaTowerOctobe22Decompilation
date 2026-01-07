y = Approach(y, y_to, 2);
x = xstart + irandom_range(-4, 4);

if (y == y_to)
{
    if (room != tower_5)
    {
        with (instance_create(x, y, obj_bossdoor))
        {
            sprite_index = other.sprite_index;
            bgsprite = other.bgsprite;
            targetRoom = other.targetRoom;
            event_perform(ev_other, ev_room_start);
        }
    }
    else
    {
        with (instance_create(x, y, obj_door))
            targetRoom = other.targetRoom;
    }
    
    instance_destroy();
}

with (obj_camera)
{
    shake_mag = 3;
    shake_mag_acc = 5 / room_speed;
}
