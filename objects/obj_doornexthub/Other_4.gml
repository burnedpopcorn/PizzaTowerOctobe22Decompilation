ini_open_from_string(obj_savesystem.ini_str);
unlocked = ini_read_real(save, "door", false);
key = ini_read_real(save, "bosskey", false);
ini_close();

if (unlocked)
    sprite_index = spr_doorvisited;

if (global.panic)
{
    instance_create(x + 50, y + 96, obj_rubble);
    instance_destroy();
}
