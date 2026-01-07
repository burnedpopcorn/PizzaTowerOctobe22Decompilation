function scr_savescore(arg0)
{
    if ((global.collect + global.collectN) >= global.srank)
    {
        global.rank = "s";
        
        if (!global.combodropped)
            global.rank = "p";
        
        if (global.snickchallenge == true)
            global.SAGEsnicksrank = true;
    }
    else if ((global.collect + global.collectN) > global.arank)
    {
        global.rank = "a";
    }
    else if ((global.collect + global.collectN) > global.brank)
    {
        global.rank = "b";
    }
    else if ((global.collect + global.collectN) > global.crank)
    {
        global.rank = "c";
    }
    else
    {
        global.rank = "d";
    }
    
    var s = 4;
    
    if (global.rank == "s" || global.rank == "p")
        s = 0;
    
    if (global.rank == "a")
        s = 1.5;
    
    if (global.rank == "b")
        s = 2.5;
    
    if (global.rank == "c")
        s = 3.5;
    
    if (global.rank == "d")
        s = 4.5;
    
    if (room != tower_entrancehall && room != tower_tutorial1)
    {
        fmod_event_instance_play(global.snd_rank);
        fmod_event_instance_set_parameter(global.snd_rank, "rank", s, true);
    }
    
    ini_open_from_string(obj_savesystem.ini_str);
    
    if (ini_read_real("Highscore", arg0, 0) < global.collect)
        ini_write_real("Highscore", arg0, global.collect);
    
    if (ini_read_real("Treasure", arg0, 0) == 0)
        ini_write_real("Treasure", arg0, global.treasure);
    
    if (global.secretfound > 3)
        global.secretfound = 3;
    
    if (ini_read_real("Secret", arg0, 0) < global.secretfound)
        ini_write_string("Secret", arg0, global.secretfound);
    
    global.newtoppin[0] = false;
    global.newtoppin[1] = false;
    global.newtoppin[2] = false;
    global.newtoppin[3] = false;
    global.newtoppin[4] = false;
    
    if (ini_read_real("Toppin", arg0 + "1", false) == 0)
    {
        if (global.shroomfollow)
            global.newtoppin[0] = true;
        
        ini_write_real("Toppin", arg0 + "1", global.shroomfollow);
    }
    
    if (ini_read_real("Toppin", arg0 + "2", false) == 0)
    {
        if (global.cheesefollow)
            global.newtoppin[1] = true;
        
        ini_write_real("Toppin", arg0 + "2", global.cheesefollow);
    }
    
    if (ini_read_real("Toppin", arg0 + "3", false) == 0)
    {
        if (global.tomatofollow)
            global.newtoppin[2] = true;
        
        ini_write_real("Toppin", arg0 + "3", global.tomatofollow);
    }
    
    if (ini_read_real("Toppin", arg0 + "4", false) == 0)
    {
        if (global.sausagefollow)
            global.newtoppin[3] = true;
        
        ini_write_real("Toppin", arg0 + "4", global.sausagefollow);
    }
    
    if (ini_read_real("Toppin", arg0 + "5", false) == 0)
    {
        if (global.pineapplefollow)
            global.newtoppin[4] = true;
        
        ini_write_real("Toppin", arg0 + "5", global.pineapplefollow);
    }
    
    ini_write_string("Ranks", arg0, global.rank);
    obj_savesystem.ini_str = ini_close();
}
