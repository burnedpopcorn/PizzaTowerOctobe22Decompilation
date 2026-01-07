function scr_player_animatronic()
{
    sprite_index = spr_pepanimatronic;
    move = key_left + key_right;
    hsp = move * movespeed;
    
    if (vsp < 0 && !key_jump2 && !jumpstop)
    {
        jumpstop = true;
        vsp /= 10;
    }
    
    if (key_jump)
        input_buffer_jump = 0;
    
    if (move != 0)
    {
        xscale = move;
        movespeed = 4;
    }
    else
    {
        movespeed = 0;
    }
    
    if (animatronic_buffer > 0)
    {
        animatronic_buffer--;
    }
    else
    {
        with (create_debris(x, y, spr_animatronicdebris))
            image_index = 0;
        
        with (create_debris(x, y, spr_animatronicdebris))
            image_index = 1;
        
        with (create_debris(x, y, spr_animatronicdebris))
            image_index = 2;
        
        state = states.normal;
    }
    
    if (animatronic_collect_buffer > 0)
    {
        animatronic_collect_buffer--;
    }
    else
    {
        animatronic_collect_buffer = 30;
        
        if (global.collect > 0)
        {
            global.collect -= 10;
            
            with (instance_create(x, y, obj_smallnumber))
            {
                number = "-10";
                negative = true;
            }
            
            repeat (10)
                create_debris(x, y, choose(spr_shroomcollect, spr_cheesecollect, spr_tomatocollect, spr_pineapplecollect, spr_sausagecollect), true);
        }
        
        if (global.collect < 0)
            global.collect = 0;
    }
    
    if (grounded && vsp > 0 && input_buffer_jump < 8)
    {
        input_buffer_jump = 8;
        vsp = -11;
        jumpstop = false;
    }
}
