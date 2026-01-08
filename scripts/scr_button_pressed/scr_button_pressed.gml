function scr_button_pressed(_gamepad)
{
    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(global.key_jump) || keyboard_check_pressed(global.key_jumpN))
        return -1;
    else if (gamepad_is_connected(_gamepad))
    {
        if (gamepad_button_check(_gamepad, gp_face1) || gamepad_button_check(_gamepad, gp_start))
            return _gamepad;
    }
    
    return -2;
}
