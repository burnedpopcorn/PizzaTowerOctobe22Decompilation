scr_destroy_tiles(32, "Tiles_1");

if (ds_list_find_index(global.saveroom, id) == -1)
{
    with (create_debris(x + 32, y + 32, spr_shotgunblockdebris))
        image_index = 0;
    
    with (create_debris(x + 32, y + 32, spr_shotgunblockdebris))
        image_index = 1;
    
    with (create_debris(x + 32, y + 32, spr_shotgunblockdebris))
        image_index = 2;
    
    scr_fmod_soundeffect(global.snd_breakblock, x, y);
    ds_list_add(global.saveroom, id);
}
