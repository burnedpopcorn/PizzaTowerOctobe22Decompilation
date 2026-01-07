function quick_ini_write_real(arg0, arg1, arg2, arg3)
{
    with (obj_savesystem)
    {
        ini_open_from_string(ini_str);
        ini_write_real(arg1, arg2, arg3);
        ini_str = ini_close();
    }
}
