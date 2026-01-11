enum debug_text_type
{
	normal = 0,
	command = 1,
	traced = 2,
	error = 3,
}

depth = -500;
DEBUG = (GM_build_type == "run");

if (parameter_count() > 2)
    DEBUG = true;

if (!DEBUG)
{
    var n = parameter_count();
    
    for (var i = 0; i < n; i++)
    {
        var s = parameter_string(i);
        
        if (s == "-debug" || s == "debug")
            DEBUG = true;
    }
}

if (!DEBUG)
    instance_destroy();

if (DEBUG)
{
    active = false;
    LOCKCAMERA = new DebugCommand("lockcam", "", "", function()
    {
        with (obj_camera)
            lock = !lock;
    });
    HIDETILES = new DebugCommand("hidetiles", "", "<bool>", function(arg0)
    {
        if (is_undefined(arg0))
            global.hidetiles = !global.hidetiles;
        else
            global.hidetiles = arg0;
        
        layer_set_visible("Tiles_BG", !global.hidetiles);
        layer_set_visible("Tiles_BG2", !global.hidetiles);
        layer_set_visible("Tiles_BG3", !global.hidetiles);
        layer_set_visible("Tiles_1", !global.hidetiles);
        layer_set_visible("Tiles_2", !global.hidetiles);
        layer_set_visible("Tiles_3", !global.hidetiles);
        layer_set_visible("Tiles_4", !global.hidetiles);
        layer_set_visible("Tiles_Foreground1", !global.hidetiles);
        layer_set_visible("Tiles_Foreground2", !global.hidetiles);
        layer_set_visible("Tiles_Foreground3", !global.hidetiles);
    });
    THROWARC = new DebugCommand("throwarc", "", "<bool>", function(arg0)
    {
        if (is_undefined(arg0))
            global.throwarc = !global.throwarc;
        else
            global.throwarc = arg0;
    });
    GOTOEDITOR = new DebugCommand("editor", "", "", function()
    {
        with (obj_player)
        {
            targetRoom = editor_room;
            targetDoor = "A";
        }
        
        instance_create_unique(0, 0, obj_fadeout);
    });
    NOCLIP = new DebugCommand("noclip", "", "", function()
    {
        with (obj_player1)
            state = states.debugstate;
    });
    GIVEKEY = new DebugCommand("givekey", "", "", function()
    {
        global.key_inv = true;
    });
    LOADTEST = new DebugCommand("loadtest", "", "", function()
    {
        with (obj_debugcontroller)
        {
            DoCommand("showcollisions 1");
            DoCommand("player_room rm_testing4 A");
        }
    });
    SETCOMBO = new DebugCommand("set_combo", "Set the combo", "<combo> <combotime:optional>", function(arg0, arg1)
    {
        if (arg0 == undefined)
            exit;
        
        if (arg1 == undefined)
            arg1 = 60;
        
        global.combo = real(arg0);
        global.combotime = real(arg1);
        
        with (obj_player)
            supercharge = 10;
    });
    GIVEHEAT = new DebugCommand("giveheat", "Gives heat", "", function()
    {
        global.style += 100;
    });
    ALLTOPPINS = new DebugCommand("alltoppins", "Adds all the toppins", "", function()
    {
        if (!instance_exists(obj_pizzakincheese))
            instance_create(obj_player1.x, obj_player1.y, obj_pizzakincheese);
        
        if (!instance_exists(obj_pizzakintomato))
            instance_create(obj_player1.x, obj_player1.y, obj_pizzakintomato);
        
        if (!instance_exists(obj_pizzakinsausage))
            instance_create(obj_player1.x, obj_player1.y, obj_pizzakinsausage);
        
        if (!instance_exists(obj_pizzakinpineapple))
            instance_create(obj_player1.x, obj_player1.y, obj_pizzakinpineapple);
        
        if (!instance_exists(obj_pizzakinshroom))
            instance_create(obj_player1.x, obj_player1.y, obj_pizzakinshroom);
        
        global.cheesefollow = true;
        global.tomatofollow = true;
        global.sausagefollow = true;
        global.pineapplefollow = true;
        global.shroomfollow = true;
    });
    PANIC = new DebugCommand("panic", "Toggles pizza time", "<fill>", function(arg0)
    {
        if (arg0 != undefined && arg0 != "")
            arg0 = get_number_string(arg0);
        else
            arg0 = 4000;
        
        global.panic = !global.panic;
        global.fill = arg0;
        
        if (global.panic)
            obj_camera.alarm[1] = 60;
        
        obj_tv.chunkmax = global.fill;
    });
    SHOW_COLLISIONS = new DebugCommand("showcollisions", "Shows the collisions", "<bool>", function(arg0)
    {
        if (arg0 == undefined)
            exit;
        
        arg0 = get_bool(arg0);
        
        if (arg0 != undefined)
        {
            showcollisions = arg0;
            event_perform(ev_other, ev_room_start);
        }
    });
    SHOW_HUD = new DebugCommand("showhud", "Shows the HUD", "<bool>", function(arg0)
    {
        if (arg0 == undefined)
            exit;
        
        arg0 = get_bool(arg0);
        show_debug_message(!arg0);
        
        if (arg0 != undefined)
        {
            showhud = arg0;
            
            with (obj_tv)
            {
                visible = arg0;
                show_debug_message(visible);
            }
            
            with (obj_camera)
            {
                visible = arg0;
                show_debug_message(visible);
            }
            
            with (obj_roomname)
            {
                visible = arg0;
                show_debug_message(visible);
            }
            
            with (obj_pigtotal)
            {
                visible = arg0;
                show_debug_message(visible);
            }
        }
    });
    PLAYER_ROOM = new DebugCommand("player_room", "Go to given room", "<targetRoom> <targetDoor>", function(arg0, arg1)
    {
        if (arg0 == undefined)
            exit;
        
        if (arg1 == undefined)
            exit;
        
        arg0 = asset_get_index(arg0);
        
        if (arg0 == -1)
            exit;
        
        with (obj_player)
        {
            targetRoom = arg0;
            targetDoor = arg1;
        }
        
        instance_create(x, y, obj_fadeout);
    });
    CAMERA_ZOOM = new DebugCommand("camera_zoom", "Zoom", "<targetzoom> <spd>", function(arg0, arg1)
    {
        if (arg0 == undefined)
            exit;
        
        if (arg1 != undefined)
            arg1 = get_number_string(arg1);
        
        with (obj_camera)
        {
            targetzoom = arg0;
            targetzoom = clamp(targetzoom, 0, max_zoom);
            
            if (arg1 != undefined)
                zoomspd = abs(arg1);
        }
    });
    DESTROYICE = new DebugCommand("destroyice", "", "", function()
    {
        instance_destroy(obj_iceblock);
        instance_destroy(obj_iceblockslope);
    });
    HARDMODE = new DebugCommand("hardmode", "Toggles hardmode", "<bool>", function(arg0)
    {
        if (arg0 == undefined)
            exit;
        
        arg0 = get_bool(arg0);
        show_debug_message(!arg0);
        
        if (arg0 != undefined)
        {
            global.hardmode = arg0;
            
            with (obj_hardmode)
                event_perform(ev_other, ev_room_start);
        }
    });
    PLAYER_SET_STATE = new DebugCommand("player_set_state", "Changes the player state", "<states.state>", function(arg0)
    {
        if (arg0 == undefined)
            exit;
        
        arg0 = state_map[? arg0];
        
        if (!is_undefined(arg0))
        {
            with (obj_player)
            {
                if (object_index == obj_player1 || global.coop)
                {
                    state = arg0;
                    var _spr = sprite_index;
                    
                    switch (arg0)
                    {
                        case states.normal:
                            _spr = spr_idle;
                            break;
                        
                        case states.cheesepep:
                            _spr = spr_cheesepep_idle;
                            break;
                        
                        case states.knightpep:
                            _spr = spr_knightpepidle;
                            break;
                        
                        case states.firemouth:
                            _spr = spr_firemouth;
                            break;
                        
                        case states.ratmount:
                            _spr = spr_player_ratmountidle;
                            break;
                    }
                    
                    sprite_index = _spr;
                    image_index = 0;
                }
            }
        }
    });
    active = false;
    showcollisions = false;
    showhud = true;
    state_map = ds_map_create();
    state_map[? "states.normal"] = states.normal;
    state_map[? "states.cheesepep"] = states.cheesepep;
    state_map[? "states.knightpep"] = states.knightpep;
    state_map[? "states.firemouth"] = states.firemouth;
    state_map[? "states.ratmount"] = states.ratmount;
    command_list = ds_list_create();
    ds_list_add(command_list, DESTROYICE, SHOW_HUD, SHOW_COLLISIONS, PLAYER_ROOM, CAMERA_ZOOM, HARDMODE, PLAYER_SET_STATE, PANIC, ALLTOPPINS, GIVEHEAT);
    ds_list_add(command_list, SETCOMBO, GIVEKEY, LOADTEST, NOCLIP, THROWARC, HIDETILES, LOCKCAMERA);
    input_text = "";
    text_list = ds_list_create();
    search_commands = ds_list_create();
    ds_list_clear(search_commands);
    search_w = 0;
    keyboard_string = "";
    
    function FindCommand(arg0)
    {
        for (var i = 0; i < ds_list_size(command_list); i++)
        {
            var b = command_list[| i];
            
            if (b.command_id == arg0)
                return b;
        }
        
        return undefined;
    }
    
    function DoCommand(arg0)
    {
        var commands = _string_split(arg0, " ");
        
        if (array_length(commands) > 1)
        {
            var c = FindCommand(commands[1]);
            
            if (c != undefined)
            {
                TextList_Add(debug_text_type.command, arg0);
                array_delete(commands, 0, 2);
                c.Invoke(commands);
                return true;
            }
            else
            {
                TextList_Add(debug_text_type.normal, arg0);
                TextList_Add(debug_text_type.error, "Invalid command");
            }
        }
        else
        {
            TextList_Add(debug_text_type.normal, arg0);
            TextList_Add(debug_text_type.error, "No text typed");
        }
        
        return false;
    }
    
    function GetDouble(arg0)
    {
        var n = string_digits(arg0);
        
        if (n != undefined && n != "")
        {
            n = real(arg0);
            return n;
        }
        
        return undefined;
    }
    
    function get_bool(arg0)
    {
        if (arg0 == "true")
        {
            arg0 = true;
            return arg0;
        }
        else if (arg0 == "false")
        {
            arg0 = false;
            return arg0;
        }
        else if (is_real(real(string_digits(arg0))))
        {
            arg0 = bool(real(string_digits(arg0)));
            return arg0;
        }
        
        return undefined;
    }
    
    function get_number_string(arg0)
    {
        var n = arg0;
        
        if (is_string(arg0))
        {
            n = real(string_digits(arg0));
            
            if (string_char_at(arg0, 1) == "-")
                n = -real(string_digits(arg0));
        }
        
        return n;
    }
}
