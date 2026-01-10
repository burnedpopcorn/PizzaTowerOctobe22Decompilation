image_speed = 0.35;

if (ANIMATION_ENDED && sprite_index == spr_pizzahead_TVprojectilebounce)
    sprite_index = spr_pizzahead_TVprojectile;

mask_index = spr_pizzahead_TVprojectile;

if (move)
{
    if (!grabbed && !ratgrabbed && !thrown)
    {
        hsp = dir * spd;
        
        if (place_meeting(x, y + 1, obj_solid) && vsp > 0)
        {
            if (bounce > 0)
            {
                vsp = -18;
                sprite_index = spr_pizzahead_TVprojectilebounce;
                image_index = 0;
                bounce--;
                
                with (obj_camera)
                {
                    shake_mag = 3;
                    shake_mag_acc = 5 / room_speed;
                }
            }
            else
            {
                instance_destroy(id, false);
                create_particle(x, y, particle.genericpoofeffect);
                move = false;
                hsp = 0;
                alarm[0] = 150;
            }
        }
        
        if (place_meeting(x + sign(hsp), y, obj_solid))
        {
            dir *= -1;
            hsp *= -1;
        }
    }
}

if (grabbed)
    hasgrabbed = true;

if (grabbed || vsp > 0)
    land = true;

if (land)
    depth = 0;

event_inherited();
