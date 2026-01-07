x += hsp;

if (instance_exists(obj_noiseboss))
{
    var ix = sign((obj_noiseboss.x + offset) - x);
    hsp = Approach(hsp, ix * 4, spd);
}
