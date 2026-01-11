function cutscene_camera_shake(_shake_mag, _shake_mag_acc)
{
    with (obj_camera)
    {
        shake_mag = _shake_mag;
        shake_mag_acc = _shake_mag_acc;
    }
    
    cutscene_end_action();
}
