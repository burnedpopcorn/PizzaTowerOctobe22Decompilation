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

setVibration = function(_player, _left_motor, _right_motor, _force)
{
    vibration[_player][0] = _left_motor;
    vibration[_player][1] = _right_motor;
    
    if (_force != undefined)
        vibration[_player][2] = _force;
};

function CheckUsedIndex(_index)
{
    for (var _x = 0; _x < 2; _x++)
    {
        if (player_input_device[_x] == _index)
            return true;
    }
    
    return false;
}
