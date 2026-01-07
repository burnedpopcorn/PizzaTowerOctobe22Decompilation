if (noshake == false)
{
    instance_create(x, y, obj_slapstar);
    instance_create(x, y, obj_slapstar);
    instance_create(x, y, obj_slapstar);
    instance_create(x, y, obj_baddiegibs);
    instance_create(x, y, obj_baddiegibs);
    instance_create(x, y, obj_baddiegibs);
    scr_soundeffect(sfx_killenemy);
    
    with (obj_camera)
    {
        shake_mag = 3;
        shake_mag_acc = 3 / room_speed;
    }
    
    instance_create(x, y, obj_bangeffect);
    
    with (create_debris(x, y, sprite_index, false))
    {
        image_index = 1;
        image_yscale = -1;
    }
}
