if (!playerid.state == states.mach3 && !playerid.state == states.mach2 && playerid.ghostdash == false && playerid.ratmount_movespeed < 12)
    instance_destroy();

visible = playerid.visible;

if (playerid.state == states.mach2)
    image_alpha = playerid.movespeed / 16;
