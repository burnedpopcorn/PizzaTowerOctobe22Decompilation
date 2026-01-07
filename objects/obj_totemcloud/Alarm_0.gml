if (active)
{
    sprite_index = spr_totemcloud_attack;
    image_index = 0;
    fmod_event_one_shot_3d("event:/sfx/misc/thundercloud", x, y);
}
