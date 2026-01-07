if (!playerid.state == UnknownEnum.Value_121 && !playerid.state == UnknownEnum.Value_104 && playerid.ghostdash == false && playerid.ratmount_movespeed < 12)
    instance_destroy();

visible = playerid.visible;

if (playerid.state == states.mach2)
    image_alpha = playerid.movespeed / 16;
