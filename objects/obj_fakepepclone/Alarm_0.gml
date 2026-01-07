with (create_red_afterimage(x, y, sprite_index, image_index - 1, image_xscale))
{
    image_yscale = other.image_yscale;
    playerid = other.id;
}

if (grounded == true)
{
    with (instance_create(x, y, obj_dashcloud2))
        image_xscale = other.image_xscale;
}
