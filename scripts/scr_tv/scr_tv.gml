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

function tv_create_prompt(_text, _type, _sprite, _textspeed)
{
    return [_text, _type, _sprite, _textspeed];
}

function tv_push_prompt(_text, _type, _sprite, _textspeed)
{
    with (obj_tv)
    {
        var b = [_text, _type, _sprite, _textspeed];
        var play = false;
        
        switch (_type)
        {
            case tvprompt.normal:
                play = true;
                ds_list_insert(tvprompts_list, 0, b);
                break;
            
            case tvprompt.trigger:
                var placed = false;
                
                for (var i = 0; i < ds_list_size(tvprompts_list); i++)
                {
                    var b2 = tvprompts_list[| i];
                    
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

function tv_push_prompt_array(_prompt)
{
    for (var i = 0; i < array_length(_prompt); i++)
    {
        with (obj_tv)
        {
            var b = _prompt[i];
            tv_push_prompt(b[0], b[1], b[2], b[3]);
        }
    }
}

function tv_push_prompt_once(_prompt, _savename)
{
    with (obj_tv)
    {
        if (special_prompts == noone)
            return false;
        
        var b = special_prompts[? _savename];
        
        if (is_undefined(b))
            return false;
        
        if (b != 1)
        {
            tv_push_prompt(_prompt[0], _prompt[1], _prompt[2], _prompt[3]);
            special_prompts[? _savename] = 1;
            ini_open_from_string(obj_savesystem.ini_str);
            ini_write_real("Prompts", _savename, 1);
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

function tv_do_expression(_sprite)
{
    with (obj_tv)
    {
        if (expressionsprite != _sprite && bubblespr == noone)
        {
            state = states.tv_whitenoise;
            expressionsprite = _sprite;
            
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
