if (state < 2)
{
    with (obj_player)
    {
        hsp = 0;
        vsp = 0;
    }
}

global.combotime = 0;
instance_destroy(obj_comboend);

if (sprite_index == spr_tvstatic)
{
    image_index -= 0.35;
    
    if (floor(image_index) <= 0)
        instance_destroy();
}
