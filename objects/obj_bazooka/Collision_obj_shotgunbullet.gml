if (sprite_index == spr_piraneapple_projectile)
{
    instance_destroy(id, false);
    
    with (instance_create(x, y, obj_sausageman_dead))
        sprite_index = spr_piraneapple_dead;
}
else
{
    instance_destroy();
}
