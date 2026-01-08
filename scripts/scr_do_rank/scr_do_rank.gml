function scr_do_rank()
{
    var ex = x;
    var ey = y;
    var cx = camera_get_view_x(view_camera[0]) + obj_screensizer.normal_size_fix_x;
    var cy = camera_get_view_y(view_camera[0]) + obj_screensizer.normal_size_fix_y;
    rankpos_x = ex - cx;
    rankpos_y = ey - cy;
    
    if (global.timeattack == true)
        obj_timeattack.stop = true;
    
    targetDoor = "none";
    obj_camera.alarm[2] = -1;
    var roomname = room_get_name(room);
    var namestring = string_letters(roomname);
    
    if (!global.tutorial_room)
    {
        scr_savescore(global.leveltosave);
        notification_push(UnknownEnum.Value_3, [global.leveltosave, global.secretfound]);
        
        with (obj_achievementtracker)
            event_perform(ev_step, ev_step_normal);
    }
    else
    {
        ini_open_from_string(obj_savesystem.ini_str);
        ini_write_real("Tutorial", "finished", true);
        obj_savesystem.ini_str = ini_close();
    }
    
    if (global.combo > 0)
    {
        global.combotime = 0;
        global.combo = 0;
        obj_camera.alarm[4] = -1;
        
        for (var i = 0; i < global.comboscore; i += 10)
            create_collect(obj_player1.x + irandom_range(-60, 60), (obj_player1.y - 100) + irandom_range(-60, 60), choose(spr_shroomcollect, spr_tomatocollect, spr_cheesecollect, spr_sausagecollect, spr_pineapplecollect));
        
        global.comboscore = 0;
    }
    
    if (!instance_exists(obj_endlevelfade))
    {
        with (instance_create(x, y, obj_endlevelfade))
        {
            do_rank = true;
            
            if (room == tower_tutorial1)
            {
                do_rank = false;
                targetRoom = tower_entrancehall;
                targetDoor = "A";
            }
            else if (room == tower_entrancehall)
            {
                do_rank = false;
                targetRoom = Endingroom;
                targetDoor = "A";
                instance_destroy(obj_pigtotal);
                audio_stop_all();
                stop_music();
                fmod_event_instance_stop(global.snd_rank);
            }
        }
    }
    
    obj_player1.state = states.door;
    obj_player1.sprite_index = obj_player1.spr_lookdoor;
    
    if (instance_exists(obj_player2))
    {
        obj_player2.state = states.door;
        obj_player2.sprite_index = obj_player2.spr_lookdoor;
        
        if (global.coop)
            obj_player2.visible = true;
    }
    
    obj_endlevelfade.alarm[0] = 235;
    image_index = 0;
    global.panic = false;
    global.snickchallenge = false;
    gamesave_async_save();
}
