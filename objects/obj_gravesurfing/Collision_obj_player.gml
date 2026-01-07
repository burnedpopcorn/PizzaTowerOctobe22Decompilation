if (buffer <= 0 && other.state != states.ghost)
{
    buffer = 50;
    image_alpha = 0;
    
    with (other)
    {
        fmod_event_one_shot_3d("event:/sfx/pep/gravecorpsestart", x, y);
        vsp = -11;
        movespeed = abs(movespeed);
        dir = xscale;
        movespeed = 13;
        instance_create(x, y, obj_jumpdust);
        sprite_index = spr_player_corpsestart;
        image_index = 0;
        
        with (obj_gravecorpse)
        {
            if (playerid == other.id)
                instance_destroy();
        }
        
        with (instance_create(x, y, obj_gravecorpse))
            playerid = other.id;
        
        state = states.trashroll;
        
        repeat (5)
        {
            with (create_debris(x, y, spr_graveyarddebris2, false))
                vsp = random_range(-8, -11);
        }
        
        create_transformation_tip(lang_get_value("gravesurftip"), "gravesurf");
    }
}
