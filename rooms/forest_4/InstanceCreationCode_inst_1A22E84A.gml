if (!global.pizzadelivery && global.pizzasdelivered < 5 && global.panic == false)
{
    if (!global.failcutscene)
    {
        if (global.pizzasdelivered <= 0)
            scene_info = [[cutscene_set_sprite, 957, 2670, 0.35, -1], [cutscene_gustavo_start], [cutscene_wait, 30], [cutscene_set_sprite, 957, 2661, 0.35, -1], [cutscene_wait, 10], [cutscene_move_player, 464, obj_gustavo.x - 48, 6, 16], [cutscene_set_sprite, 464, 2650, 0.35, 1], [cutscene_set_sprite, 957, 2662, 0.35, -1], [cutscene_gustavo_end]];
        else
            scene_info = [[cutscene_set_sprite, 957, 2661, 0.35, -1]];
    }
    else
    {
        scene_info = [[cutscene_gustavofail_start], [cutscene_wait, 20], [cutscene_set_sprite, 957, 2665, 0.35, -1], [cutscene_waitfor_sprite, 957], [cutscene_set_sprite, 957, 2666, 0.35, -1], [cutscene_wait, 50], [cutscene_set_sprite, 957, 2667, 0.35, -1], [cutscene_set_sprite, 464, 2653, 0.35, 1], [cutscene_waitfor_sprite, 957], [cutscene_set_sprite, 957, 2668, 0.35, -1], [cutscene_set_hsp, 957, -12], [cutscene_set_sprite, 464, 2657, 0.35, 1], [cutscene_waitfor_sprite, 464], [cutscene_set_sprite, 464, 2658, 0.35, 1], [cutscene_check_collision, 957, 464], [cutscene_set_hsp, 957, 0], [cutscene_gustavofail_end, 100], [cutscene_move_actor, 957, obj_gustavo.xstart, obj_gustavo.ystart, 0.05], [cutscene_set_sprite, 957, 2661, 0.35, -1]];
    }
}
else
{
    scene_info = [[cutscene_wait, 2]];
}
