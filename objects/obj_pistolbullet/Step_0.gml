with (instance_place(x + spd, y, obj_shotgunblock))
    instance_destroy();

with (instance_place(x, y - spdh, obj_shotgunblock))
    instance_destroy();

with (instance_place(x + spd, y, obj_destructibles))
    instance_destroy();

var _x = x;
x += (image_xscale * spd);
y += -spdh;

for (var i = 0; i < array_length(collision_list); i++)
{
    var b = collision_list[i];
    var _inst = collision_line(x, y, _x, y, b, false, true);
    
    if (_inst == noone)
        _inst = instance_place(x, y, b);
    
    with (_inst)
    {
        switch (object_index)
        {
            case obj_vigilanteboss:
                if (state != states.hit && (state != states.mach2 || kick) && (flickertime <= 0 && vsp > 0))
                {
                    flash = true;
                    
                    repeat (3)
                        create_debris(other.x, other.y, spr_slimedebris);
                    
                    instance_create(other.x, other.y, obj_bangeffect);
                    
                    if (bullethit < 8)
                    {
                        bullethit++;
                    }
                    else
                    {
                        repeat (8)
                            create_debris(other.x, other.y, spr_slimedebris);
                        
                        instance_create(other.x, other.y, obj_parryeffect);
                        scr_sleep(30);
                        state = states.hit;
                        linethrown = true;
                        hitX = x;
                        hitY = y;
                        hitLag = 10;
                        thrown = true;
                        mach2 = false;
                        hithsp = other.image_xscale * 20;
                        hitvsp = -7;
                        image_xscale = -other.image_xscale;
                        fmod_event_one_shot_3d("event:/sfx/enemies/kill", x, y);
                        
                        if (elitehit <= 1 && phase == 1)
                        {
                            state = states.phase1hurt;
                            sprite_index = spr_playerV_hurt;
                            hsp = 0;
                            vsp = 0;
                            buildup = 80;
                        }
                    }
                    
                    instance_destroy(other);
                }
                
                break;
            
            case obj_pizzafaceboss_p2:
                if (state != states.hit && (flickertime <= 0 && grounded && vsp > 0))
                {
                    flash = true;
                    
                    repeat (3)
                        create_debris(other.x, other.y, spr_slimedebris);
                    
                    instance_create(other.x, other.y, obj_bangeffect);
                    
                    if (bullethit < 22)
                    {
                        bullethit++;
                    }
                    else
                    {
                        repeat (8)
                            create_debris(other.x, other.y, spr_slimedebris);
                        
                        instance_create(other.x, other.y, obj_parryeffect);
                        scr_sleep(30);
                        fmod_event_one_shot_3d("event:/sfx/enemies/kill", x, y);
                        
                        if (elitehit <= 1)
                        {
                            state = states.phase1hurt;
                            sprite_index = spr_pizzahead_hurt;
                            hsp = 0;
                            vsp = 0;
                            buildup = 80;
                            hitX = x;
                            hitY = y;
                        }
                        else
                        {
                            elitehit--;
                        }
                    }
                    
                    instance_destroy(other);
                }
                
                break;
            
            case obj_vigilantecow:
            case obj_pizzahead_cog:
            case obj_targetguy:
                flash = true;
                flashbuffer = 8;
                instance_create(other.x, other.y, obj_bangeffect);
                
                if (bullethit > 0)
                {
                    bullethit--;
                }
                else
                {
                    instance_create(other.x, other.y, obj_parryeffect);
                    scr_sleep(30);
                    fmod_event_one_shot_3d("event:/sfx/enemies/kill", x, y);
                    instance_destroy();
                }
                
                instance_destroy(other);
                break;
            
            case obj_johnecheese:
                repeat (3)
                    create_debris(other.x, other.y, spr_slimedebris);
                
                instance_create(other.x, other.y, obj_bangeffect);
                instance_create(other.x, other.y, obj_parryeffect);
                instance_destroy();
                break;
        }
    }
}
