with (obj_pepperman)
{
    if (wastedhits == other.number && other.created == false)
    {
        with (other)
        {
            with (instance_create(x, -85, obj_pepper_marbleblock))
                image_xscale = other.image_xscale;
            
            created = true;
        }
    }
}
