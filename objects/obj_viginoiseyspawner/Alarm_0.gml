if (!instance_exists(obj_noisey))
{
    var _x = irandom_range(100, room_width - 100);
    
    with (instance_create(_x, room_height + 100, obj_gustavograbbable))
    {
        sprite_index = spr_lonegustavo_jumpstart;
        image_index = 0;
        state = states.pizzaheadjump;
        hsp = 0;
        vsp = -20;
    }
}
