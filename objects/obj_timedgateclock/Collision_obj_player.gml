if (sprite_index != spr_button_pressed && sprite_index != spr_button_goingpressed)
{
    timedgate_trigger();
    notification_push(notifications.fell_into_pit, [room, id, time]);
}

with (obj_timedgateclock)
{
    if (sprite_index != spr_button_pressed && sprite_index != spr_button_goingpressed)
    {
        sprite_index = spr_button_goingpressed;
        image_index = 0;
    }
}

global.timedgatetimer = true;
global.timedgatetime = time;
global.timedgatetimemax = time;

with (instance_create_unique(obj_player1.x, obj_player1.y, obj_clock))
    objectID = obj_player1.id;
