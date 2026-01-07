function scr_button_pressed(arg0)
{
    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(global.key_jump) || keyboard_check_pressed(global.key_jumpN))
    {
        return -1;
    }
    else if (gamepad_is_connected(arg0))
    {
        if (gamepad_button_check(arg0, gp_face1) || gamepad_button_check(arg0, gp_start))
            return arg0;
    }
    
    return -2;
}
