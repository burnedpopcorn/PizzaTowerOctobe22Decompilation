if (global.switchbuffer > 0)
    global.switchbuffer--;

if (sprite_index == spr_peppinoswitch2 && instance_exists(obj_charswitch_intro) && obj_charswitch_intro.state != states.fall)
    image_index = 0;

if (sprite_index == spr_peppinoswitch2 && ANIMATION_ENDED)
{
    with (obj_player1)
    {
        visible = true;
        gustavodash = 0;
        ratmount_movespeed = 8;
        isgustavo = false;
        state = states.normal;
        brick = false;
        x = obj_peppinoswitch.x;
        y = obj_peppinoswitch.y;
        global.switchbuffer = 100;
    }
    
    sprite_index = spr_gustavosign;
}

if (sprite_index == spr_gustavosign && global.panic != escape)
    visible = false;
else
    visible = true;
