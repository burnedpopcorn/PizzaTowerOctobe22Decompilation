function scr_add_wave(arg0, arg1, arg2, arg3, arg4)
{
    var _wave = arg0;
    var _enemynumber = arg1;
    var _obj = arg2;
    var _random = arg3;
    var _spawnpoint = arg4;
    baddie_arr[_wave][_enemynumber] = _obj;
    baddie_random[_wave][_enemynumber] = _random;
    
    if (!_random)
        baddie_spawnpoint[_wave][_enemynumber] = _spawnpoint;
}
