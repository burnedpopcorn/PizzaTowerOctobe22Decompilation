if (!pizzahead)
{
    if (dir == -1)
    {
        with (instance_create(room_width + 10, 400, obj_peppermanartdude))
            image_xscale = -1;
    }
    
    if (dir == 1)
    {
        with (instance_create(-10, 400, obj_peppermanartdude))
            image_xscale = 1;
    }
}

alarm[8] = 1000;
