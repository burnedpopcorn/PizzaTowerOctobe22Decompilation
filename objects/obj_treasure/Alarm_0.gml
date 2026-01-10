var p = noone;

if (player == obj_hardmode)
    p = obj_player1.id;
else if (player == obj_bosskeynoise)
    p = obj_player2.id;

p.state = states.normal;
p.landAnim = false;
