function cutscene_camera_shake(arg0, arg1)
{
    with (obj_camera)
    {
        shake_mag = arg0;
        shake_mag_acc = arg1;
    }
    
    cutscene_end_action();
}
