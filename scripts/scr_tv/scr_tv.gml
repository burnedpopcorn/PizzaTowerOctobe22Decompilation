function tv_set_idle()
{
    with (obj_tv)
    {
        state = states.normal;
        sprite_index = spr_tv_idle;
    }
}

function tv_reset()
{
    with (obj_tv)
    {
        state = states.normal;
        sprite_index = spr_tv_idle;
        ds_list_clear(tvprompts_list);
    }
}

function tv_create_prompt(arg0, arg1, arg2, arg3)
{
    return [arg0, arg1, arg2, arg3];
}

function tv_push_prompt(arg0, arg1, arg2, arg3)
{
    with (obj_tv)
    {
        var b = [arg0, arg1, arg2, arg3];
        var play = false;
        
        switch (arg1)
        {
            case tvprompt.normal:
                play = true;
                ds_list_insert(tvprompts_list, 0, b);
                break;
            
            case tvprompt.trigger:
                var placed = false;
                
                for (var i = 0; i < ds_list_size(tvprompts_list); i++)
                {
                    var b2 = ds_list_find_value(tvprompts_list, i);
                    
                    if (b2[1] == tvprompt.transfo)
                    {
                        if (i == 0)
                            play = true;
                        
                        ds_list_insert(tvprompts_list, i, b);
                        placed = true;
                        break;
                    }
                }
                
                if (!placed)
                    ds_list_add(tvprompts_list, b);
                
                break;
            
            case tvprompt.transfo:
                ds_list_add(tvprompts_list, b);
                break;
        }
        
        if (play)
            state = states.normal;
    }
}

function tv_push_prompt_array(arg0)
{
    for (var i = 0; i < array_length(arg0); i++)
    {
        with (obj_tv)
        {
            var b = arg0[i];
            tv_push_prompt(b[0], b[1], b[2], b[3]);
        }
    }
}

function tv_push_prompt_once(arg0, arg1)
{
    with (obj_tv)
    {
        if (special_prompts == noone)
            return false;
        
        var b = ds_map_find_value(special_prompts, arg1);
        
        if (is_undefined(b))
            return false;
        
        if (b != 1)
        {
            tv_push_prompt(arg0[0], arg0[1], arg0[2], arg0[3]);
            ds_map_set(special_prompts, arg1, 1);
            ini_open_from_string(obj_savesystem.ini_str);
            ini_write_real("Prompts", arg1, 1);
            obj_savesystem.ini_str = ini_close();
            return true;
        }
        
        return false;
    }
}

function tv_default_condition()
{
    return place_meeting(x, y, obj_player);
}

function tv_do_expression(arg0)
{
    with (obj_tv)
    {
        if (expressionsprite != arg0 && bubblespr == noone)
        {
            state = states.tv_whitenoise;
            expressionsprite = arg0;
            
            switch (expressionsprite)
            {
                case spr_tv_exprhurt:
                case spr_tv_hurtG:
                    expressionbuffer = 60;
                    break;
                
                case spr_tv_exprcollect:
                    expressionbuffer = 150;
                    
                    if (obj_player.isgustavo)
                        expressionsprite = spr_tv_happyG;
                    
                    break;
            }
        }
    }
}
