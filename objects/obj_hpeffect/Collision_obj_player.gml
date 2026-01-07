if (finish)
{
    scr_fmod_soundeffect(global.snd_collect, x, y);
    
    with (obj_camera)
        healthshaketime = 30;
    
    var val = 200;
    
    if (other.object_index == obj_player1)
        global.collect += val;
    else
        global.collectN += val;
    
    with (instance_create(x, y, obj_smallnumber))
        number = string(val);
    
    instance_destroy();
}
