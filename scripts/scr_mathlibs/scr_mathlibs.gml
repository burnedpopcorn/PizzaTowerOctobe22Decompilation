function Vector2(_x, _y) constructor
{
    static Update = function(_x, _y)
    {
        x = _x;
        y = _y;
    };
    
    static UpdateVector = function(_vector)
    {
        x = _vector.x;
        y = _vector.y;
    };
    
    static Add = function(_x, _y)
    {
        x += _x;
        y += _y;
    };
    
    static AddVector = function(_vector)
    {
        x += _vector.x;
        y += _vector.y;
    };
    
    static Multiply = function(_x, _y)
    {
        x *= _x;
        y *= _y;
    };
    
    static Divide = function(_x, _y)
    {
        x /= _x;
        y /= _y;
    };
    
    static MultiplyVector = function(_vector)
    {
        x *= _vector.x;
        y *= _vector.y;
    };
    
    static DivideVector = function(_vector)
    {
        x /= _vector.x;
        y /= _vector.y;
    };
    
    x = _x;
    y = _y;
}

// https://forum.gamemaker.io/index.php?threads/smooth-camera-rotation.84059/
function cycle(_value, _min, _max)
{
	var result, delta;
	delta = (_max - _min);
	// % is remainder-of-division operator here.
	// limit input to (-delta .. +delta):
	result = (_value - _min) % delta;
	// wrap negative results around the limit:
	if (result < 0) result += delta;
	// return adjusted input:
	return result + _min;
}
function angle_rotate(_angle, _target, _speed)
{
	var diff;
	// 180 is to be replaced by "pi" for radians
	diff = cycle(_target - _angle, -180, 180);
	// clamp rotations by speed:
	if (diff < -_speed) return _angle - _speed;
	if (diff > _speed) return _angle + _speed;
	// if difference within speed, rotation's done:
	return _target;
}

function get_velocity(a, b)
{
	return a / b;
}

function Wave(from, to, duration, offset, time = noone)
{
	// https://forum.gamemaker.io/index.php?threads/wave-script.62475/
	var a4 = (to - from) * 0.5;
	
	var t = current_time;
	if time != noone
		t = time;
	
	return from + a4 + (sin((((t * 0.001) + (duration * offset)) / duration) * (pi * 2)) * a4);
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
        angle = 45;
    else
        angle = 135;
    
    return angle;
}
