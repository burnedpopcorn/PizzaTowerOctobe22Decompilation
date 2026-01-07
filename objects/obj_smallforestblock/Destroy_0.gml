if (room == custom_lvl_room)
    tile_layer_delete_at(1, x, y);

if (ds_list_find_index(global.saveroom, id) == -1)
{
    repeat (2)
    {
        with (create_debris(x + random_range(0, sprite_width), y + random_range(0, sprite_height), spr_forestblockdebris, false))
        {
            hsp = random_range(-5, 5);
            vsp = random_range(-10, 10);
            image_speed = 0;
        }
    }
    
    notification_push(notifications.baddie_killed_projectile, [object_index]);
    scr_sleep(5);
    scr_fmod_soundeffect(global.snd_breakblock, x, y);
    ds_list_add(global.saveroom, id);
}
