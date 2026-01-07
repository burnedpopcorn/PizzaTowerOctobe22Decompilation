function scr_player_ratmountskid()
{
    hsp = xscale * -movespeed;
    movespeed = Approach(movespeed, 0, 0.8);
    
    if (brick)
        sprite_index = spr_ratmount_skid;
    else
        sprite_index = spr_lonegustavo_skid;
    
    gustavodash = 0;
    ratmount_movespeed = 8;
    image_speed = 0.4;
    
    if (movespeed <= 0 || abs(hsp) <= 0)
    {
        movespeed = 0;
        state = states.ratmount;
    }
    
    if (key_jump && !key_up)
        input_buffer_jump = 0;
    
    if (input_buffer_jump < 8 && grounded && sprite_index != spr_player_ratmountswallow)
    {
        particle_set_scale(particle.highjumpcloud2, xscale, 1);
        create_particle(x, y, particle.highjumpcloud2, 0);
        fmod_event_one_shot_3d("event:/sfx/pep/jump", x, y);
        
        if (brick)
            sprite_index = spr_player_ratmountjump;
        else if (ratmount_movespeed >= 12)
            sprite_index = spr_lonegustavo_dashjump;
        else
            sprite_index = spr_player_ratmountgroundpound;
        
        image_index = 0;
        movespeed = hsp;
        jumpAnim = true;
        state = states.ratmountjump;
        vsp = -11;
        jumpstop = false;
    }
    
    if (((key_slap2 && key_up) || key_shoot2) && brick)
    {
        ratmount_kickbrick();
        movespeed = -movespeed;
        hsp = movespeed;
        ratmount_movespeed = 8;
    }
    
    if (key_slap2 && !key_up)
    {
        if (brick == true)
        {
            with (instance_create(x, y, obj_brickcomeback))
                wait = true;
        }
        
        brick = false;
        movespeed = -movespeed;
        ratmountpunchtimer = 25;
        gustavohitwall = false;
        state = states.ratmountpunch;
        image_index = 0;
        
        if (move != 0)
            xscale = move;
        
        movespeed = xscale * 12;
        sprite_index = spr_lonegustavo_punch;
    }
    
    if (!instance_exists(dashcloudid) && grounded)
    {
        with (instance_create(x, y, obj_dashcloud))
        {
            image_xscale = other.xscale;
            other.dashcloudid = id;
        }
    }
}
