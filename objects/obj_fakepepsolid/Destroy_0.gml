scr_fmod_soundeffect(global.snd_breakblock, x, y);

repeat (30)
    create_debris(irandom_range(x, x + sprite_width), irandom_range(y, y + sprite_height), spr_debris);
