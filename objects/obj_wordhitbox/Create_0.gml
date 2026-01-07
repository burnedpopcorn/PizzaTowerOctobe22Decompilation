event_inherited();
dmg = 40;
var t = spr_pickle_dead;

if (global.coop)
    t = instance_nearest(x, y, obj_player);

direction = point_direction(x, y, t.x, t.y) + irandom_range(-4, 4);
parryable = true;
parried = false;

function parry()
{
    var prevparried = parried;
    SUPER_parry();
    
    if (prevparried != parried)
    {
        direction *= -1;
        dmg = 100;
        spd = 30;
    }
}
