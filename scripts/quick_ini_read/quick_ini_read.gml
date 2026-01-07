function quick_ini_read_real(arg0, arg1, arg2, arg3)
{
    ini_open_from_string(obj_savesystem.ini_str);
    var b = ini_read_real(arg1, arg2, arg3);
    ini_close();
    return b;
}
