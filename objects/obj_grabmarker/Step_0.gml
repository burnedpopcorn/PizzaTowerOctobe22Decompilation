if (instance_exists(ID))
{
    if (ID.object_index == obj_swordstone)
        y = ID.y - 20;
}
else if (ID != noone)
    instance_destroy();