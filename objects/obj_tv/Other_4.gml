tv_bg_index = 0;

switch (global.leveltosave)
{
    case "entrance":
        tv_bg_index = 1;
        break;
    
    case "medieval":
        tv_bg_index = 2;
        break;
    
    case "ruin":
        tv_bg_index = 3;
        break;
    
    case "dungeon":
        tv_bg_index = 4;
        break;
    
    case "badland":
        tv_bg_index = 5;
        break;
    
    case "graveyard":
        tv_bg_index = 6;
        break;
    
    case "farm":
        tv_bg_index = 7;
        break;
    
    case "saloon":
        tv_bg_index = 8;
        break;
    
    case "plage":
        tv_bg_index = 9;
        break;
    
    case "forest":
        tv_bg_index = 10;
        break;
    
    case "space":
        tv_bg_index = 11;
        break;
    
    case "minigolf":
        tv_bg_index = 12;
        break;
    
    case "street":
        tv_bg_index = 13;
        break;
    
    case "sewer":
        tv_bg_index = 14;
        break;
    
    case "industrial":
        tv_bg_index = 15;
        break;
    
    case "freezer":
        tv_bg_index = 16;
        break;
    
    case "chateau":
        tv_bg_index = 17;
        break;
    
    case "kidsparty":
        tv_bg_index = 18;
        break;
    
    case "war":
        tv_bg_index = 19;
        break;
}

if (special_prompts == -4 && room != Realtitlescreen && room != characterselect)
{
    special_prompts = ds_map_create();
    ini_open(concat("saveData", global.currentsavefile, ".ini"));
    ds_map_set(special_prompts, "knight", ini_read_real("Prompts", "knight", 0));
    ds_map_set(special_prompts, "boxxedpep", ini_read_real("Prompts", "boxxedpep", 0));
    ds_map_set(special_prompts, "mort", ini_read_real("Prompts", "mort", 0));
    ds_map_set(special_prompts, "squished", ini_read_real("Prompts", "squished", 0));
    ds_map_set(special_prompts, "skateboard", ini_read_real("Prompts", "skateboard", 0));
    ds_map_set(special_prompts, "cheeseball", ini_read_real("Prompts", "cheeseball", 0));
    ds_map_set(special_prompts, "shotgun", ini_read_real("Prompts", "shotgun", 0));
    ds_map_set(special_prompts, "ghost", ini_read_real("Prompts", "ghost", 0));
    ds_map_set(special_prompts, "firemouth", ini_read_real("Prompts", "firemouth", 0));
    ds_map_set(special_prompts, "fireass", ini_read_real("Prompts", "fireass", 0));
    ds_map_set(special_prompts, "bombpep", ini_read_real("Prompts", "bombpep", 0));
    ds_map_set(special_prompts, "rocket", ini_read_real("Prompts", "rocket", 0));
    ini_close();
}

if (room == Realtitlescreen)
{
    if (special_prompts != -4)
        ds_map_destroy(special_prompts);
    
    special_prompts = -4;
}

if (room == entrance_1)
{
    global.srank = 23000;
    global.arank = global.srank - (global.srank / 4);
    global.brank = global.srank - ((global.srank / 4) * 2);
    global.crank = global.srank - ((global.srank / 4) * 3);
}

if (room == medieval_1 && global.snickchallenge == false)
{
    global.srank = 33700;
    global.arank = global.srank - (global.srank / 4);
    global.brank = global.srank - ((global.srank / 4) * 2);
    global.crank = global.srank - ((global.srank / 4) * 3);
}

if (room == ruin_1 && global.snickchallenge == false)
{
    global.srank = 25000;
    global.arank = global.srank - (global.srank / 4);
    global.brank = global.srank - ((global.srank / 4) * 2);
    global.crank = global.srank - ((global.srank / 4) * 3);
}

if (room == dungeon_1 && global.snickchallenge == false)
{
    global.srank = 27000;
    global.arank = global.srank - (global.srank / 4);
    global.brank = global.srank - ((global.srank / 4) * 2);
    global.crank = global.srank - ((global.srank / 4) * 3);
}

if (room == badland_1)
{
    global.srank = 21000;
    global.arank = global.srank - (global.srank / 4);
    global.brank = global.srank - ((global.srank / 4) * 2);
    global.crank = global.srank - ((global.srank / 4) * 3);
}

if (room == graveyard_1)
{
    global.srank = 28000;
    global.arank = global.srank - (global.srank / 4);
    global.brank = global.srank - ((global.srank / 4) * 2);
    global.crank = global.srank - ((global.srank / 4) * 3);
}

if (room == saloon_1)
{
    global.srank = 27000;
    global.arank = global.srank - (global.srank / 4);
    global.brank = global.srank - ((global.srank / 4) * 2);
    global.crank = global.srank - ((global.srank / 4) * 3);
}

if (room == farm_2)
{
    global.srank = 19000;
    global.arank = global.srank - (global.srank / 4);
    global.brank = global.srank - ((global.srank / 4) * 2);
    global.crank = global.srank - ((global.srank / 4) * 3);
}

if (room == plage_entrance)
{
    global.srank = 27000;
    global.arank = global.srank - (global.srank / 4);
    global.brank = global.srank - ((global.srank / 4) * 2);
    global.crank = global.srank - ((global.srank / 4) * 3);
}

if (room == forest_1)
{
    global.srank = 27000;
    global.arank = global.srank - (global.srank / 4);
    global.brank = global.srank - ((global.srank / 4) * 2);
    global.crank = global.srank - ((global.srank / 4) * 3);
}

if (room == space_1)
{
    global.srank = 30000;
    global.arank = global.srank - (global.srank / 4);
    global.brank = global.srank - ((global.srank / 4) * 2);
    global.crank = global.srank - ((global.srank / 4) * 3);
}

if (room == minigolf_1)
{
    global.srank = 27000;
    global.arank = global.srank - (global.srank / 4);
    global.brank = global.srank - ((global.srank / 4) * 2);
    global.crank = global.srank - ((global.srank / 4) * 3);
}

if (room == street_intro)
{
    global.srank = 25000;
    global.arank = global.srank - (global.srank / 4);
    global.brank = global.srank - ((global.srank / 4) * 2);
    global.crank = global.srank - ((global.srank / 4) * 3);
}

if (room == sewer_1)
{
    global.srank = 25000;
    global.arank = global.srank - (global.srank / 4);
    global.brank = global.srank - ((global.srank / 4) * 2);
    global.crank = global.srank - ((global.srank / 4) * 3);
}

if (room == industrial_1)
{
    global.srank = 27000;
    global.arank = global.srank - (global.srank / 4);
    global.brank = global.srank - ((global.srank / 4) * 2);
    global.crank = global.srank - ((global.srank / 4) * 3);
}

if (room == freezer_1)
{
    global.srank = 18000;
    global.arank = global.srank - (global.srank / 4);
    global.brank = global.srank - ((global.srank / 4) * 2);
    global.crank = global.srank - ((global.srank / 4) * 3);
}

if (room == chateau_1)
{
    global.srank = 26000;
    global.arank = global.srank - (global.srank / 4);
    global.brank = global.srank - ((global.srank / 4) * 2);
    global.crank = global.srank - ((global.srank / 4) * 3);
}

if (room == kidsparty_1)
{
    global.srank = 27000;
    global.arank = global.srank - (global.srank / 4);
    global.brank = global.srank - ((global.srank / 4) * 2);
    global.crank = global.srank - ((global.srank / 4) * 3);
}

if (room == war_1)
{
    global.srank = 12000;
    global.arank = global.srank - (global.srank / 4);
    global.brank = global.srank - ((global.srank / 4) * 2);
    global.crank = global.srank - ((global.srank / 4) * 3);
}

if (room == custom_lvl_room)
    alarm[1] = 4;
