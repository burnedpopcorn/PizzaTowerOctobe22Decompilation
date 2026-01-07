with (instance_create(0, 0, obj_pizzahead_whitefade))
{
    persistent = true;
    whitefade = 5;
    deccel = 0.05;
}

room = boss_pizzafacehub;

with (obj_player)
{
    state = states.normal;
    landAnim = false;
}
