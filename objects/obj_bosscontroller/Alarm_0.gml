with (obj_player1)
{
    state = states.normal;
    isgustavo = false;
}

with (obj_bosskeyspawn)
{
    with (instance_create(x, -100, obj_bosskey))
    {
        save = other.save;
        y_to = other.y;
    }
}
