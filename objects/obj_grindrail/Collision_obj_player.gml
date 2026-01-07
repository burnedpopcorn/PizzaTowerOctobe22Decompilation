if (place_meeting(x, y, other) && other.state != states.tumble && other.state != states.backbreaker && other.state != states.chainsaw && other.state != states.bump && other.y > other.yprevious && other.y < y)
{
    if (!other.isgustavo)
    {
        other.y = y - 49;
        other.state = states.grind;
    }
    else if (other.state != states.ratmountgrind)
    {
        with (other)
        {
            if (brick == true)
            {
                with (instance_create(x, y, obj_brickcomeback))
                    wait = true;
            }
            
            with (instance_create(x, y - 5, obj_parryeffect))
            {
                sprite_index = spr_grabhangeffect;
                image_speed = 0.35;
            }
            
            brick = false;
        }
        
        other.y = y + 8;
        other.state = states.ratmountgrind;
    }
}
