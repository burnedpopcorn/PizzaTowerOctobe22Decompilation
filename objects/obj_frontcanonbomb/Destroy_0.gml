instance_create(x, y, obj_canonexplosion);

if (room != plage_shiptop)
{
    repeat (10)
    {
        with (create_debris(x, y, spr_beachsandparticle))
            vsp = random_range(-7, -11);
    }
}
