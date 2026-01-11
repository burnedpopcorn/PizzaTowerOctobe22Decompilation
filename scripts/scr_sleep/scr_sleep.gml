function scr_sleep(_ms)
{
    var time = current_time;
    var ms = _ms;
    
    do { } until ((current_time - time) >= round(ms));
    
    return current_time - time;
}
