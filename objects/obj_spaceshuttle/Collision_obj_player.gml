with (other)
{
    if (other.state == states.normal && state != UnknownEnum.Value_292 && key_up && grounded && ((state == states.ratmount && brick) || state == states.normal || state == states.mach1 || state == states.mach3 || state == states.pogo || state == states.mach3 || state == states.Sjumpprep))
    {
        instance_create(x, y, obj_genericpoofeffect);
        other.state = states.hit;
        other.hitLag = 150;
        other.hitX = other.x;
        other.hitY = other.y;
        instance_destroy(other.arrowID);
        
        with (obj_player)
        {
            if (check_player_coop())
            {
                hsp = 0;
                movespeed = 0;
                vsp = 0;
                state = UnknownEnum.Value_292;
                visible = false;
                sprite_index = spr_idle;
            }
        }
    }
}
