function scr_sleep(arg0)
{
    var time = current_time;
    var ms = arg0;
    
    do { } until ((current_time - time) >= round(ms));
    
    return current_time - time;
}
