if (playerid != noone)
{
    with (playerid)
    {
        if (floor(image_index) >= 9)
            global.noisejetpack = false;
        
        if (ANIMATION_ENDED)
        {
            state = states.normal;
            landAnim = false;
            
            with (other)
            {
                playerid = noone;
                
                if (ds_list_find_index(global.saveroom, id) == -1)
                {
                    ds_list_add(global.saveroom, id);
                    global.collect += 1000;
                    global.combotime = 60;
                    
                    with (instance_create(x, y, obj_smallnumber))
                        number = string(1000);
                }
            }
        }
    }
}

if (sprite_index == spr_freemilksuprised && ANIMATION_ENDED)
    sprite_index = spr_freemilk;
