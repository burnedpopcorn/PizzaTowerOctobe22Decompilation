if (elitehit <= 0 && pizzahead && destroyable)
{
    instance_create_unique(0, 0, obj_viginoiseyspawner);
    
    with (instance_create_unique(room_width / 4, room_height + 100, obj_vigilanteboss))
    {
        with (obj_bosscontroller)
        {
            boss_hpsprite = spr_bossfight_vigiHP;
            boss_palette = spr_bossfight_vigipalette;
        }
        
        instance_destroy(spotlightID);
        pizzahead = true;
        flickertime = 0;
        state = states.pizzaheadjump;
        sprite_index = spr_playerV_hurt;
        image_index = 0;
        image_speed = 0.35;
        hsp = 0;
        vsp = -18;
        elitehit = 4;
        destroyable = true;
        vigilante_start_attack(0, 5);
        vigilante_add_attack(0, 5, UnknownEnum.Value_1);
        vigilante_add_attack(0, 5, UnknownEnum.Value_1);
        vigilante_add_attack(0, 5, UnknownEnum.Value_9, 25);
        vigilante_add_attack(0, 5, UnknownEnum.Value_0, 5);
        vigilante_add_attack(0, 5, UnknownEnum.Value_0, 5);
        vigilante_add_attack(0, 5, UnknownEnum.Value_8, 20);
        vigilante_start_attack(0, 6);
        vigilante_add_attack(0, 6, UnknownEnum.Value_1);
        vigilante_add_attack(0, 6, UnknownEnum.Value_1);
        vigilante_add_attack(0, 6, UnknownEnum.Value_9, 25);
        vigilante_add_attack(0, 6, UnknownEnum.Value_0, 5);
        vigilante_add_attack(0, 6, UnknownEnum.Value_0, 5);
        vigilante_add_attack(0, 6, UnknownEnum.Value_8, 20);
        vigilante_start_attack(0, 7);
        vigilante_add_attack(0, 7, UnknownEnum.Value_6);
        vigilante_add_attack(0, 7, UnknownEnum.Value_8, 20);
        vigilante_add_attack(0, 7, UnknownEnum.Value_5);
        vigilante_add_attack(0, 7, UnknownEnum.Value_4, 200);
        vigilante_add_attack(0, 7, UnknownEnum.Value_9, 25);
        vigilante_start_attack(0, 8);
        vigilante_add_attack(0, 8, UnknownEnum.Value_1);
        vigilante_add_attack(0, 8, UnknownEnum.Value_1);
        vigilante_add_attack(0, 8, UnknownEnum.Value_9, 25);
        vigilante_add_attack(0, 8, UnknownEnum.Value_1);
        vigilante_add_attack(0, 8, UnknownEnum.Value_1);
        vigilante_add_attack(0, 8, UnknownEnum.Value_8, 20);
        vigilante_start_attack(0, 9);
        vigilante_add_attack(0, 9, UnknownEnum.Value_5);
        vigilante_add_attack(0, 9, UnknownEnum.Value_8);
        vigilante_add_attack(0, 9, UnknownEnum.Value_9, 25);
    }
}

event_inherited();
