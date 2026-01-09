if (!pause && obj_player1.key_start)
{
    var _cutscenehandler = false;
    
    with (obj_cutscene_handler)
    {
        if (!loop)
            _cutscenehandler = true;
    }
    
    with (obj_secretportal)
    {
        if (touched)
            _cutscenehandler = true;
    }
    
    with (obj_secretportalstart)
        _cutscenehandler = true;
    
    with (obj_titlecard)
        _cutscenehandler = true;
    
    if (obj_savesystem.state == 0 && !_cutscenehandler && (room != rank_room && room != Realtitlescreen && room != timesuproom) && !instance_exists(obj_jumpscare) && !instance_exists(obj_fadeout) && !instance_exists(obj_technicaldifficulty))
    {
        selected = 0;
        fadein = true;
        pause = true;
        fade = 0;
        savedmusicmuffle = fmod_get_parameter("musicmuffle");
        fmod_set_parameter("musicmuffle", 1, false);
        
        if (sprite_exists(screensprite))
            sprite_delete(screensprite);
        
        if (sprite_exists(guisprite))
            sprite_delete(guisprite);
        
        screensprite = sprite_create_from_surface(application_surface, 0, 0, surface_get_width(application_surface), surface_get_height(application_surface), false, false, 0, 0);
        guisprite = sprite_create_from_surface(obj_screensizer.gui_surf, 0, 0, surface_get_width(obj_screensizer.gui_surf), surface_get_height(obj_screensizer.gui_surf), false, false, 0, 0);
        cursor_x = -60;
        cursor_y = -300;
        cursor_index = 0;
        scr_pause_deactivate_objects();
    }
}

with (obj_player1)
{
    other.paletteselect = paletteselect;
    other.spr_palette = spr_palette;
}

border1_xstart = 0;
border1_ystart = SCREEN_HEIGHT;
border1_xend = -96;
border1_yend = SCREEN_HEIGHT + 100;
border2_xstart = SCREEN_WIDTH;
border2_ystart = SCREEN_HEIGHT;
border2_xend = SCREEN_WIDTH + 96;
border2_yend = SCREEN_HEIGHT + 100;
vine_ystart = 0;
vine_yend = -117;

if (!start)
{
    start = true;
    border2_x = border2_xend;
    border2_y = border2_yend;
    border1_x = border1_xend;
    border1_y = border1_yend;
    vine_y = vine_yend;
}

var a = 0.1;

if (fadein)
{
    fade = Approach(fade, 1, 0.1);
    border1_x = lerp(border1_x, border1_xstart, a);
    border1_y = lerp(border1_y, border1_ystart, a);
    border2_x = lerp(border2_x, border2_xstart, a);
    border2_y = lerp(border2_y, border2_ystart, a);
    vine_y = lerp(vine_y, vine_ystart, a);
    cursor_x = lerp(cursor_x, 0, 0.05);
    cursor_y = lerp(cursor_y, 0, a);
}
else
{
    fade = Approach(fade, 0, 0.1);
    border1_x = lerp(border1_x, border1_xend, a);
    border1_y = lerp(border1_y, border1_yend, a);
    border2_x = lerp(border2_x, border2_xend, a);
    border2_y = lerp(border2_y, border2_yend, a);
    vine_y = lerp(vine_y, vine_yend, a);
    cursor_x = lerp(cursor_x, 20, 0.05);
    cursor_y = lerp(cursor_y, -100, a);
}

cursor_index += 0.35;
pause_update_priests();
var prevpause = pause;

if (pause && !instance_exists(obj_option))
{
    scr_getinput();
    moveselect = -key_up2 + key_down2;
    selected += moveselect;
    
    if (moveselect != 0 && selected >= 0 && selected <= 3)
        fmod_event_one_shot("event:/sfx/pep/step");
    
    selected = clamp(selected, 0, array_length(pause_menu) - 1);
    
    if (key_jump)
    {
        switch (selected)
        {
            case 0:
                scr_pause_activate_objects();
                break;
            
            case 2:
                if (!global.snickchallenge)
                {
                    var rm = global.leveltorestart;
                    ds_list_clear(global.saveroom);
                    ds_list_clear(global.baddieroom);
                    
                    if (rm != -4 && rm != -1)
                    {
                        stop_music();
                        obj_music.music = -4;
                        instance_destroy(obj_fadeout);
                        scr_pause_activate_objects();
                        global.levelreset = false;
                        scr_playerreset();
                        global.levelreset = true;
                        scr_room_goto(rm);
                        pause = false;
                        obj_player1.targetDoor = "A";
                        obj_player1.restartbuffer = 15;
                        obj_player2.restartbuffer = 15;
                        
                        if (instance_exists(obj_player2))
                            obj_player2.targetDoor = "A";
                    }
                    else
                    {
                        fmod_event_one_shot("event:/sfx/enemies/projectile");
                    }
                }
                
                break;
            
            case 1:
                fmod_event_one_shot("event:/sfx/enemies/projectile");
                
                with (instance_create(x, y, obj_option))
                    depth = other.depth - 1;
                
                break;
            
            case 3:
                stop_music();
                obj_music.music = -4;
                
                if (room == hub_room1 || room == Finalintro || room == characterselect || room == cowboytask || room == Titlescreen || room == Mainmenu || room == Scootertransition || room == rm_levelselect || string_letters(room_get_name(room)) == "towertutorial" || (string_copy(room_get_name(room), 1, 5) == "tower" && !global.panic))
                {
                    pause = false;
                    scr_pause_activate_objects();
                    room = Realtitlescreen;
                    
                    with (obj_player1)
                    {
                        character = "P";
                        scr_characterspr();
                    }
                    
                    global.leveltosave = -4;
                    scr_playerreset();
                    alarm[0] = 2;
                    obj_player1.state = states.titlescreen;
                    obj_player2.state = states.titlescreen;
                    obj_player1.targetDoor = "A";
                    
                    if (instance_exists(obj_player2))
                        obj_player2.targetDoor = "A";
                    
                    global.cowboyhat = false;
                    global.coop = false;
                }
                else
                {
                    pause = false;
                    scr_pause_activate_objects();
                    
                    with (instance_create(0, 0, obj_backtohub_fadeout))
                        fadealpha = 1;
                    
                    scr_playerreset();
                    global.levelreset = true;
                    obj_player1.targetDoor = "HUB";
                    
                    if (instance_exists(obj_player2))
                        obj_player2.targetDoor = "HUB";
                    
                    global.leveltorestart = -4;
                    global.leveltosave = -4;
                }
                
                break;
        }
    }
    
    if (prevpause && !pause)
        fmod_set_parameter("musicmuffle", savedmusicmuffle, false);
}
