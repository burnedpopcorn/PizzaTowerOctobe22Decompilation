if (!fadeout)
{
    image_speed = 0;
    image_index = image_number - 1;
    fadeout = true;
    
    if (monster)
        scr_monster_activate();
    
    if (content != -4)
    {
        with (instance_create(x, y, content))
        {
            create_particle(x, y, particle.genericpoofeffect);
            
            if (object_index == obj_bazooka)
            {
                sprite_index = spr_piraneapple_projectile;
                destroy = false;
            }
        }
    }
}
