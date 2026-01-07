var p = (player_id == obj_hardmode) ? obj_player1.id : obj_player2.id;

with (other)
{
    image_xscale *= -1;
    team = 1;
}

if (!collisioned)
    event_user(0);
