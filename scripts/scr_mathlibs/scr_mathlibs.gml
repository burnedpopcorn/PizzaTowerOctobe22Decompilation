function Vector2(arg0, arg1) constructor
{
    static Update = function(arg0, arg1)
    {
        x = arg0;
        y = arg1;
    };
    
    static UpdateVector = function(arg0)
    {
        x = arg0.x;
        y = arg0.y;
    };
    
    static Add = function(arg0, arg1)
    {
        x += arg0;
        y += arg1;
    };
    
    static AddVector = function(arg0)
    {
        x += arg0.x;
        y += arg0.y;
    };
    
    static Multiply = function(arg0, arg1)
    {
        x *= arg0;
        y *= arg1;
    };
    
    static Divide = function(arg0, arg1)
    {
        x /= arg0;
        y /= arg1;
    };
    
    static MultiplyVector = function(arg0)
    {
        x *= arg0.x;
        y *= arg0.y;
    };
    
    static DivideVector = function(arg0)
    {
        x /= arg0.x;
        y /= arg0.y;
    };
    
    x = arg0;
    y = arg1;
}

function cycle(arg0, arg1, arg2)
{
    var delta = arg2 - arg1;
    var result = (arg0 - arg1) % delta;
    
    if (result < 0)
        result += delta;
    
    return result + arg1;
}

function angle_rotate(arg0, arg1, arg2)
{
    var diff = cycle(arg1 - arg0, -180, 180);
    
    if (diff < -arg2)
        return arg0 - arg2;
    
    if (diff > arg2)
        return arg0 + arg2;
    
    return arg1;
}

function get_velocity(arg0, arg1)
{
    return arg0 / arg1;
}

function Wave(arg0, arg1, arg2, arg3, arg4 = noone)
{
    var a4 = (arg1 - arg0) * 0.5;
    var t = current_time;
    
    if (arg4 != noone)
        t = arg4;
    
    return arg0 + a4 + (sin((((t * 0.001) + (arg2 * arg3)) / arg2) * (2 * pi)) * a4);
}

function distance_to_pos(arg0, arg1, arg2, arg3, arg4, arg5)
{
    return abs(arg0 - arg2) <= arg4 && abs(arg1 - arg3) <= arg5;
}

function distance_between_points(arg0, arg1, arg2, arg3)
{
    return sqrt(sqr(arg2 - arg0) + sqr(arg3 - arg1));
}

function calculate_jump_velocity_alt(arg0, arg1, arg2, arg3)
{
    var xx = arg0 - x;
    var yy = arg1 - y;
    var g = arg3;
    var tmp = power(arg2, 4) - (g * ((g * power(xx, 2)) + (2 * yy * power(arg2, 2))));
    
    if (tmp > 0)
    {
        var a1, a2;
        
        if (xx == 0)
        {
            a1 = 1.5707963267948966;
            
            if (yy < 0)
                a2 = -1.5707963267948966;
            else
                a2 = 1.5707963267948966;
        }
        else
        {
            a1 = arctan2(power(arg2, 2) + sqrt(tmp), g * xx);
            a2 = arctan2(power(arg2, 2) - sqrt(tmp), g * xx);
        }
        
        hsp = cos(a1) * arg2 * 1.2;
        vsp = cos(a2) * arg2;
        
        if (vsp > 0)
            vsp *= -1;
        
        hsp = abs(hsp) * sign(xx);
    }
}

function calculate_jump_velocity(arg0, arg1, arg2, arg3)
{
    var a = get_projectile_angle(x, y, arg0, arg1, arg2, arg3);
    hsp = lengthdir_x(arg2, a);
    vsp = lengthdir_y(arg2, a);
}

function get_projectile_angle(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var xt = floor(arg2 - arg0);
    var yt = -floor(arg3 - arg1);
    var root = power(arg4, 4) - (arg5 * ((arg5 * sqr(xt)) + (2 * sqr(arg4) * yt)));
    var angle = 0;
    
    if (root > 0)
    {
        angle = radtodeg(arctan((sqr(arg4) + sqrt(root)) / (arg5 * xt)));
        
        if (xt < 0)
            angle -= 180;
    }
    else if (xt > 0)
    {
        angle = 45;
    }
    else
    {
        angle = 135;
    }
    
    return angle;
}
