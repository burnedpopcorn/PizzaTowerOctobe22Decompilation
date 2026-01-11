function scr_player_addslopemomentum(_horizontal_slope_value, _vertical_slope_value)
{
    with (instance_place(x, y + 1, obj_slope))
    {
        if (sign(image_xscale) == -sign(other.xscale))
        {
            if (abs(image_yscale) < abs(image_xscale))
                other.movespeed += _horizontal_slope_value;
            else
                other.movespeed += _vertical_slope_value;
        }
    }
}

function scr_pizzaball_addslopemomentum(_horizontal_slope_value, _vertical_slope_value)
{
    with (instance_place(x, y + 1, obj_slope))
    {
        if (sign(image_xscale) == -sign(other.image_xscale))
        {
            if (abs(image_yscale) < abs(image_xscale))
                other.slopespeed += _horizontal_slope_value;
            else
                other.slopespeed += _vertical_slope_value;
        }
        else if (abs(image_yscale) < abs(image_xscale))
            other.slopespeed -= _horizontal_slope_value;
        else
            other.slopespeed -= _vertical_slope_value;
    }
    
    if (slopespeed < 0)
        slopespeed = 0;
    
    if (slopespeed > 10)
        slopespeed = 10;
    
    if (movespeed < 1)
        slopespeed = 0;
}
