if (sprite_index != spr_mortspawn && sprite_index != spr_mortfall)
{
    with (other)
    {
        if (state != states.mort && state != states.mortjump && state != states.mortattack && state != states.morthook && state != states.ridecow)
        {
            repeat (6)
                create_debris(x, y, spr_feather);
            
            mort = true;
            instance_create_unique(x, y, obj_mortfollow);
            movespeed = hsp;
            state = states.mort;
            create_transformation_tip(lang_get_value("morttip"), "mort");
            instance_destroy(other);
        }
    }
}
