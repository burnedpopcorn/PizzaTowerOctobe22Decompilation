player_input_device[0] = -2;
player_input_device[1] = -2;
device_selected[0] = false;
device_selected[1] = false;
press_start = false;
deactivated = false;
device_to_reconnect = 0;
prevstate[0] = states.titlescreen;
prevstate[1] = states.titlescreen;
vibration[0][0] = 0;
vibration[0][1] = 0;
vibration[0][2] = 0;
vibration[1][0] = 0;
vibration[1][1] = 0;
vibration[1][2] = 0;

setVibration = function(arg0, arg1, arg2, arg3)
{
    vibration[arg0][0] = arg1;
    vibration[arg0][1] = arg2;
    
    if (arg3 != undefined)
        vibration[arg0][2] = arg3;
};

function CheckUsedIndex(arg0)
{
    for (var _x = 0; _x < 2; _x++)
    {
        if (player_input_device[_x] == arg0)
            return true;
    }
    
    return false;
}
