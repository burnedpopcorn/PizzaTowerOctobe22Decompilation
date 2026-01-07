state = 0;
credits_y = room_height + 100;
credits_str = [];
draw_set_font(global.creditsfont);
credits_height = string_height("ABCDEFGHIJKLMNOPQRST");
var file = file_text_open_read("credits.txt");

while (!file_text_eof(file))
    array_push(credits_str, file_text_readln(file));

file_text_close(file);
credits_height *= array_length(credits_str);
fade = 0;
whitefade = 0;
image_speed = 0.35;
puffbuffer = 0;
introbuffer = 0;
spawn_arr = [obj_hppickup, obj_vigilantecow, obj_escapespawn, obj_totem, obj_noisebigbomb, 3480, obj_rocketdead, obj_timeattack, obj_badratspawner, obj_johnecheese_spawner, obj_laundrymachine, obj_hiddenobject, obj_cutoff, obj_pepper_groundpoundspot, 2383, obj_destroyablegolf, obj_tank, 1414, obj_fakepepspawner, obj_press, 1734, obj_farmerparent, 3323, obj_iceblock_breakable, obj_pizzahead_haywire, obj_pause, 2094, 1047, obj_boilingsauce, 2642, obj_lapportal, obj_menutv, obj_laundrymachine, obj_mine, 1041, 2137, 3612, obj_gerome, obj_file3, obj_pizzacoinindicator];

with (instance_create(0, 0, obj_introprop))
{
    sprite_index = spr_towerending_bg;
    depth = -3;
}

with (instance_create(0, 0, obj_introprop))
{
    sprite_index = spr_towerending;
    depth = -7;
}

with (instance_create(145, 345, obj_introprop))
{
    sprite_index = spr_towerending_mrstick;
    depth = -8;
}

with (instance_create(369, 409, obj_introprop))
{
    sprite_index = spr_towerending_gustavo;
    depth = -8;
}

with (instance_create(484, 386, obj_introprop))
{
    sprite_index = spr_towerending_brick;
    depth = -8;
}

with (instance_create(288, 408, obj_introprop))
{
    sprite_index = spr_towerending_peppino;
    depth = -9;
}

towerID = instance_create(468, 188, obj_introprop);

with (towerID)
{
    hitY = y - 100;
    depth = -5;
    sprite_index = spr_towerending_tower;
}

with (obj_player)
    state = states.titlescreen;

depth = -10;
