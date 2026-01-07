if (!instance_exists(ID))
{
    instance_destroy();
    exit;
}

x = ID.x;
y = ID.y;
sprite_index = ID.sprite_index;
mask_index = ID.mask_index;
