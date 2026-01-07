if (obj_player.ghostdash == false && cooldown == 0)
    visible = true;

if (cooldown > 0)
    cooldown--;

if (obj_player.state != states.ghost)
    image_alpha = 0.35;
else
    image_alpha = 1;
