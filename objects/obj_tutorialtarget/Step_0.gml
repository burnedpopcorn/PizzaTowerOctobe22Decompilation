var j = id;

with (instance_place(x, y, obj_baddiecollisionbox))
{
    if (baddieID.thrown == true)
        instance_destroy(j);
}
