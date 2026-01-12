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
spawn_arr = 
[
	spr_forknight_walk, 
	spr_slimemove, 
	spr_pepgoblin, 
	spr_ancho, 
	spr_pizzagoblin_walk, 
	spr_badrat_walk, 
	spr_banditochicken_chase, 
	spr_tank_walk, 
	spr_bigcheese_walk, 
	spr_canongoblin_walk, 
	spr_robot_walk, 
	spr_coolpinea, 
	spr_minijohn_charge, 
	spr_fencer_charge, 
	spr_farmer1_walk, 
	spr_farmer2_walk, 
	spr_peasanto_walk, 
	spr_ghostknight_move, 
	spr_ghoul_attack, 
	spr_golfburger_walk, 
	spr_golfdemon_walk, 
	spr_indiancheese_walk, 
	spr_kentukybomber_move, 
	spr_kentukykenny_walk, 
	spr_ufolive, 
	spr_archergoblin_walk, 
	spr_patroller_walk, 
	spr_pepbat_move, 
	spr_pickle_walk, 
	spr_pizzaball_roll, 
	spr_pizzard_walk, 
	spr_pizzice_walk, 
	spr_robot_walk, 
	spr_sausageman_walk, 
	spr_pizzaslug_walk, 
	spr_newpizzice_walk, 
	spr_soldier_walk, 
	spr_swedishmonkey_walk, 
	spr_shrimp_walk, 
	spr_treasureguy_escape
];

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
