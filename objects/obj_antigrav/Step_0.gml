if (use_collision)
    scr_collide();

if (sprite_index == spr_antigrav_activate && ANIMATION_ENDED)
    sprite_index = spr_antigrav;
