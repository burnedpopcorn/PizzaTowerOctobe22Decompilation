switch (state)
{
    case states.transitioncutscene:
        if (ANIMATION_END)
        {
            state = states.normal;
            introbuffer = 50;
        }
        
        break;
    
    case states.normal:
        if (introbuffer > 0)
        {
            introbuffer--;
        }
        else
        {
            image_speed = 0;
            image_index = image_number - 1;
            state = states.fall;
            obj_camera.lock = false;
        }
        
        break;
    
    case states.fall:
        image_index -= 0.35;
        
        if (image_index <= 0)
            instance_destroy();
        
        break;
}
