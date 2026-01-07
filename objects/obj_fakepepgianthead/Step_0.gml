targetplayer = global.coop ? instance_nearest(x, y, obj_player) : obj_player1;
var _g = distance_to_point(targetplayer.x, targetplayer.y);

if (_g < 150)
    movespeed = 2;
else if (_g < 300)
    movespeed = 3;
else if (_g < 450)
    movespeed = 7;
else
    movespeed = 11;

x += movespeed;
