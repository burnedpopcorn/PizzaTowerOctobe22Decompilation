if (!variable_global_exists("titlecutscene"))
    global.titlecutscene = true;

if (global.titlecutscene)
    scene_info = [[cutscene_title_start], [cutscene_set_sprite, 464, 1708, 0.35, 1], [cutscene_wait, 120], [cutscene_title_middle], [cutscene_set_sprite, 464, 788, 0.3, -1], [cutscene_set_vsp, 464, -6], [cutscene_waitfor_sprite, 464], [cutscene_title_end]];
else
    scene_info = [[cutscene_wait, 2]];
