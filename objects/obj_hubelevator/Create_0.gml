state = states.normal;
hub_array[0] = [247, "RECEPTION"];
hub_array[1] = [448, "PIZZA TOWER LOBBY"];
hub_array[2] = [294, "FARMLAND"];
hub_array[3] = [31, "PIZZALAND EXIT"];
hub_array[4] = [384, "INDUSTRIAL COMPLEX"];
isgustavo = false;
playerid = -4;
selected = 0;

switch (room)
{
    case hub_room1:
        selected = 0;
        break;
    
    case hub_room2:
        selected = 1;
        break;
}
