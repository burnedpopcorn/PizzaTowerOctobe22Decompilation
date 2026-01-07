if (global.levelcomplete && !global.factorycutscene)
{
    currentroom = room;
    global.factorycutscene = true;
    scene_info = [[cutscene_entrance_start], [cutscene_waitfor_sprite, 464], [cutscene_player_idleanim], [cutscene_change_room, 205], [cutscene_set_player_visible, false], [cutscene_set_player_pos, 428, 296], [cutscene_wait, 100], [cutscene_change_room, 656], [cutscene_set_player_visible, false], [cutscene_set_player_pos, 684, 506], [cutscene_wait, 100], [cutscene_change_room, currentroom], [cutscene_set_player_visible, true], [cutscene_factory_end], [cutscene_save_game]];
}
else if (global.levelcomplete)
{
    global.levelcomplete = false;
    scene_info = [[cutscene_save_game]];
}
else
{
    scene_info = [[cutscene_wait, 20]];
}
