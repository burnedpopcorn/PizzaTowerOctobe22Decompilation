var t = id;

with (other)
{
    if (state != states.gotoplayer && state != states.ghost && state != states.actor)
    {
        if (boxxed == false && isgustavo == false && other.sprite_index == spr_dashpad)
        {
            if (state == states.animatronic)
            {
                var i = 0;
                
                repeat (3)
                {
                    with (create_debris(x, y, spr_animatronicdebris))
                        image_index = i;
                    
                    i++;
                }
            }
            
            var changecoord = true;
            
            if (place_meeting(x, y, obj_superspring))
                changecoord = false;
            
            if (changecoord)
                y = other.y - 14;
            
            vsp = 0;
            create_particle(x, y, particle.jumpdust, 0);
            
            if (character == "P")
            {
                if (sprite_index != spr_dashpadmach)
                {
                    sprite_index = spr_dashpadmach;
                    image_index = 0;
                }
            }
            else if (character == "N")
            {
                if (sprite_index != spr_crazyrun)
                {
                    sprite_index = spr_crazyrun;
                    image_index = 0;
                }
            }
            
            machhitAnim = false;
            state = states.mach3;
            xscale = sign(other.image_xscale);
            dir = xscale;
            
            if (movespeed < 14)
            {
                movespeed = 14;
                hsp = xscale * movespeed;
            }
            else
            {
                movespeed += 0.5;
                hsp = xscale * movespeed;
            }
        }
        else
        {
            if (boxxed && other.sprite_index != spr_dashpad)
            {
                var changecoord = true;
                
                if (place_meeting(x, y, obj_superspring))
                    changecoord = false;
                
                if (changecoord)
                    y = other.y - 14;
                
                vsp = 0;
                create_particle(x, y, particle.jumpdust, 0);
                xscale = sign(other.image_xscale);
                dir = xscale;
                boxxeddash = true;
                
                if (abs(movespeed) < 14)
                    movespeed = xscale * 14;
                else
                    movespeed += (xscale * 0.5);
                
                sprite_index = spr_boxxedpepwalk;
                state = states.boxxedpep;
            }
            
            if (isgustavo && gusdashpadbuffer == 0)
            {
                var changecoord = true;
                
                if (place_meeting(x, y, obj_superspring))
                    changecoord = false;
                
                if (changecoord)
                    y = other.y - 14;
                
                vsp = 0;
                create_particle(x, y, particle.jumpdust, 0);
                xscale = sign(other.image_xscale);
                dir = xscale;
                
                with (instance_create(x, y, obj_crazyrunothereffect))
                    image_xscale = t.image_xscale;
                
                with (instance_create(x, y, obj_superdashcloud))
                    image_xscale = t.image_xscale;
                
                ratmount_movespeed = 14;
                gustavodash = 51;
                state = states.ratmount;
                
                if (abs(movespeed) < 14)
                    movespeed = other.image_xscale * 14;
                
                gusdashpadbuffer = 25;
            }
        }
    }
}
