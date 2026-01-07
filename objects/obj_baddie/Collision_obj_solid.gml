if (state != states.pizzaheadjump && use_collision && state != states.grabbed && state != states.pummel && state != states.hit && state != UnknownEnum.Value_266 && (!place_meeting(x, y, obj_destructibles) || place_meeting(x, y, obj_onewaybigblock)))
    instance_destroy();
