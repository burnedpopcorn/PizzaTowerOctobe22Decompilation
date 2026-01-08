instance_destroy();
var gh = golfhit;

with (instance_create(0, 0, obj_pizzaball_rank))
{
    if (global.golfhit <= gh[0])
    {
        collect = 400;
        sprite_index = spr_pizzaball_rank1;
    }
    else if (global.golfhit <= gh[1])
    {
        collect = 250;
        sprite_index = spr_pizzaball_rank2;
    }
    else if (global.golfhit <= gh[2])
    {
        collect = 100;
        sprite_index = spr_pizzaball_rank3;
    }
    else
    {
        collect = 0;
        sprite_index = spr_pizzaball_rank4;
    }
    
    collectminus = round(collect / 10);
    notification_push(UnknownEnum.Value_16, [sprite_index]);
}

global.golfhit = 0;
