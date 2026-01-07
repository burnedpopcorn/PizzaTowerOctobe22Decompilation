if (expand)
{
    radius += 15;
    
    if (radius > (obj_screensizer.actual_width * obj_screensizer.actual_height))
        instance_destroy();
}

if (!instance_exists(objectID))
    instance_destroy();
