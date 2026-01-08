function GamepadSetVibration(_player, _left_motor, _right_motor, _force)
{
    with (obj_inputAssigner)
        setVibration(_player, _left_motor, _right_motor, _force);
}
