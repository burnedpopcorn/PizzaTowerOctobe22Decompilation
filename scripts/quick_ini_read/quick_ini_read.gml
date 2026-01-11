// _file is unused
function quick_ini_read_real(_file, _section, _key, _value)
{
    ini_open_from_string(obj_savesystem.ini_str);
    var b = ini_read_real(_section, _key, _value);
    ini_close();
    return b;
}
