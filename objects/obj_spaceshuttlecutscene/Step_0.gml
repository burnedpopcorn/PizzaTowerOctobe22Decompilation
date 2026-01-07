if (buffer > 0)
    buffer--;
else if (!instance_exists(obj_fadeout))
    instance_create(0, 0, obj_fadeout);

var w = sprite_get_width(bg_space1);
var h = sprite_get_height(bg_space1);
var dir = point_direction(w, 0, 0, h);
bg_x += lengthdir_x(bg_spd, dir);
bg_y -= lengthdir_y(bg_spd, dir);

if (bg_x <= 0 && bg_y <= w)
{
    bg_x = w;
    bg_y = 0;
}

if (fadein)
{
    var t = 0.5;
    
    if (start)
        fade = Approach(fade, t, 0.05);
    else
        fade = Approach(fade, t, 0.1);
    
    if (fade >= t)
    {
        fadein = false;
        
        if (!start)
            start = true;
    }
}
else
{
    fade = Approach(fade, 0, 0.05);
    
    if (fade <= 0)
        fadein = true;
}
