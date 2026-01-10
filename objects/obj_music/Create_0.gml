secret = false;
secretend = false;
pillar_on_camera = false;
prevpillar_on_camera = false;
music_map = ds_map_create();
music = noone;
pillarmusicID = fmod_event_create_instance("event:/music/pillarmusic");
panicmusicID = fmod_event_create_instance("event:/music/pizzatime");
panicstart = false;
add_music(Mainmenu, "event:/music/title", noone, false);
add_music(tower_tutorial1, "event:/music/tutorial", noone, false);
add_music(tower_entrancehall, "event:/music/hub", noone, false, hub_state);
add_music(tower_1, "event:/music/hub", noone, false, hub_state);
add_music(tower_2, "event:/music/hub", noone, false, hub_state);
add_music(tower_3, "event:/music/hub", noone, false, hub_state);
add_music(tower_4, "event:/music/hub", noone, false, hub_state);
add_music(tower_5, "event:/music/hub", noone, false, hub_state);
add_music(tower_finalhallway, "event:/music/finalescape", noone, false);
add_music(tower_pizzafacehall, "event:/music/finalescape", noone, false);
add_music(boss_vigilante, "event:/music/boss/vigilante", noone, false);
add_music(boss_fakepep, "event:/music/boss/fakepep", noone, false);
add_music(boss_fakepephallway, "event:/music/pillarmusic", noone, false);
add_music(boss_fakepepkey, "event:/music/boss/fakepep", noone, false);
add_music(boss_noise, "event:/music/boss/noise", noone, false);
add_music(boss_pepperman, "event:/music/boss/pepperman", noone, false);
add_music(boss_pizzaface, "event:/music/boss/pizzaface", noone, false, function(arg0, arg1)
{
    if (arg0 == 25)
        fmod_event_instance_set_parameter(arg1, "state", 0, true);
    else if (arg0 == 150)
        fmod_event_instance_set_parameter(arg1, "state", 4, false);
});
add_music(entrance_1, "event:/music/w1/entrance", "event:/music/w1/medievalsecret", false);
add_music(medieval_1, "event:/music/w1/medieval", "event:/music/w1/medievalsecret", false, function(arg0, arg1, arg2)
{
    if (!global.panic && (arg0 == 436 || arg0 == 370 || arg0 == 437 || arg0 == 440))
        fmod_set_parameter("musicmuffle", 0.6, false);
    else
        fmod_set_parameter("musicmuffle", 0, false);
});
add_music(ruin_1, "event:/music/w1/ruin", "event:/music/w1/ruinsecret", false);
add_music(ruin_6, "event:/music/w1/ruin", "event:/music/w1/ruinsecret", true);
add_music(ruin_7, "event:/music/w1/ruinremix", "event:/music/w1/ruinsecret", true);
add_music(dungeon_1, "event:/music/w1/dungeon", "event:/music/w1/dungeonsecret", false);
add_music(dungeon_8, "event:/music/w1/dungeon", "event:/music/w1/dungeonsecret", false);
add_music(dungeon_9, "event:/music/w1/dungeondepth", "event:/music/w1/dungeonsecret", false);
add_music(badland_1, "event:/music/w2/desert", "event:/music/w2/desertsecret", false);
add_music(badland_8b, "event:/music/w2/desert", "event:/music/w2/desertsecret", true);
add_music(badland_9, "event:/music/w2/ufo", "event:/music/w2/desertsecret", true);
add_music(badland_mart4, "event:/music/w2/ufo", "event:/music/w2/desertsecret", true);
add_music(badland_10, "event:/music/w2/desert", "event:/music/w2/desertsecret", true);
add_music(farm_2, "event:/music/w2/farm", "event:/music/w2/farmsecret", false);
add_music(graveyard_1, "event:/music/w2/graveyard", "event:/music/w1/medievalsecret", false);
add_music(saloon_1, "event:/music/w2/saloon", "event:/music/w2/saloonsecret", false);
add_music(plage_entrance, "event:/music/w3/beach", "event:/music/w1/medievalsecret", false);
add_music(forest_1, "event:/music/w3/forest", "event:/music/w1/medievalsecret", false);
add_music(forest_G1, "event:/music/w3/forest", "event:/music/w1/medievalsecret", true);
add_music(forest_G1b, "event:/music/w3/gustavo", "event:/music/w1/medievalsecret", false);
add_music(forest_5, "event:/music/w3/forest", "event:/music/w1/medievalsecret", false);
add_music(minigolf_1, "event:/music/w3/golf", "event:/music/w1/medievalsecret", false);
add_music(space_1, "event:/music/w3/space", "event:/music/w3/spacesecret", false);
add_music(freezer_1, "event:/music/w4/freezer", "event:/music/w1/medievalsecret", false);
add_music(industrial_1, "event:/music/w4/industrial", "event:/music/w1/medievalsecret", false);
add_music(sewer_1, "event:/music/w4/sewer", "event:/music/w1/medievalsecret", false);
add_music(street_1, "event:/music/w4/street", "event:/music/w1/medievalsecret", false);
add_music(chateau_1, "event:/music/w5/chateau", "event:/music/w1/medievalsecret", false);
add_music(kidsparty_1, "event:/music/w5/kidsparty", "event:/music/w1/medievalsecret", false);
add_music(war_1, "event:/music/w5/war", "event:/music/w1/medievalsecret", false);
