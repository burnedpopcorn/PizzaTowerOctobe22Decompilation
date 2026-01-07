function scr_loophallway(arg0)
{
    if (arg0.start)
    {
        var yy = y - arg0.y;
        var _per = yy / arg0.sprite_height;
        
        with (obj_loophallway)
        {
            if (id != arg0.id && !start)
            {
                other.x = x + (sprite_width / 2);
                other.y = (y + (sprite_height * _per)) - 1;
                
                if (other.object_index == obj_vigilanteboss)
                    other.oldtargetspot = noone;
            }
        }
    }
}
