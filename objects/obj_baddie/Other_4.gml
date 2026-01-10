var _destroyed = false;

if (ds_list_find_index(global.baddieroom, id) != -1)
{
    _destroyed = true;
    instance_destroy();
}

if (escape == true && !_destroyed)
{
    if (escapespawnID == noone)
    {
        with (instance_create(x, y, obj_escapespawn))
        {
            baddieID = other.id;
            other.escapespawnID = id;
        }
        
        instance_deactivate_object(id);
    }
}

if (elite && object_index != obj_robot)
{
    hp += 1;
    elitehp = hp;
}
