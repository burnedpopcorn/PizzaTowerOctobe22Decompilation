if (room != kidsparty_entrance1)
{
    var roomname = room_get_name(room);
    roomname = string_letters(roomname);
    
    if (roomname == "kidspartyfloor" || roomname == "kidspartyentrance" || roomname == "kidspartybasementsecret" || roomname == "kidspartysecret" || roomname == "streetbacon")
    {
        kidsparty_lightning = true;
        dark_lightning = false;
    }
    else
    {
        kidsparty_lightning = false;
        dark_lightning = false;
    }
}
else
{
    kidsparty_lightning = false;
    dark_lightning = false;
}

if (room == dungeon_5 || room == dungeon_6)
{
    use_dark = true;
    dark_alpha = 1;
}
else
{
    use_dark = false;
}
