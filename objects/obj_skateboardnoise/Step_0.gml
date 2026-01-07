hsp = spd * image_xscale;

if (place_meeting(x + sign(hsp), y, obj_solid))
    instance_destroy();

scr_collide();

if (playerid != -4)
{
    with (playerid)
    {
        if (state != UnknownEnum.Value_285)
        {
            other.playerid = -4;
        }
        else
        {
            x = other.x;
            y = other.y;
            hsp = 0;
            vsp = 0;
        }
    }
}
