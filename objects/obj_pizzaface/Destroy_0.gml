with (instance_create(obj_screensizer.actual_width * 0.25, y, obj_shakeanddie))
    sprite_index = spr_pizzahead_intro1;

fmod_event_one_shot_3d("event:/sfx/misc/explosion", x, y);
fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y);
