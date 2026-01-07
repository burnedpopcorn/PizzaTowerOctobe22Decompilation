ds_list_add(global.saveroom, id);
global.gerome = true;
instance_create(x, y, obj_geromefollow);
instance_create(x, y, obj_taunteffect);
instance_destroy();

with (obj_player)
{
}
