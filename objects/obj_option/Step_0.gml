if (instance_exists(obj_keyconfig))
    exit;

scr_getinput();
var m = menus[menu];
var move = key_down2 - key_up2;

if (move != 0)
{
    slidebuffer = 0;
    slidecount = 0;
}

optionselected += move;
optionselected = clamp(optionselected, 0, array_length(m.options) - 1);
var option = m.options[optionselected];
var move2 = key_left2 + key_right2;

switch (option.type)
{
    case UnknownEnum.Value_2:
        if (key_jump && option.func != -4)
            option.func();
        
        break;
    
    case UnknownEnum.Value_0:
        if (key_jump || -key_left2 || key_right2)
        {
            option.value = !option.value;
            
            if (option.on_changed != -4)
                option.on_changed(option.value);
        }
        
        break;
    
    case UnknownEnum.Value_1:
        if (move2 != 0)
        {
            option.value += move2;
            
            if (option.value > (array_length(option.values) - 1))
                option.value = 0;
            
            if (option.value < 0)
                option.value = array_length(option.values) - 1;
            
            if (option.on_changed != -4)
                option.on_changed(option.values[option.value].value);
        }
        
        break;
    
    case UnknownEnum.Value_3:
        move2 = key_left + key_right;
        
        if (move2 != 0 && slidebuffer <= 0)
        {
            option.moved = true;
            option.value += move2;
            option.value = clamp(option.value, 0, 100);
            slidebuffer = 10;
            slidecount++;
            
            if (slidecount > 4)
                slidebuffer = 5;
            else if (slidecount > 8)
                slidebuffer = 1;
        }
        
        if (move2 == 0)
            slidecount = 0;
        
        break;
}

for (var i = 0; i < array_length(m.options); i++)
{
    var b = m.options[i];
    
    if (b.type == UnknownEnum.Value_3)
    {
        if (b.moved && move2 == 0)
        {
            b.moved = false;
            
            if (b.on_changed != -4)
                b.on_changed(b.value);
        }
    }
}

if (slidebuffer > 0)
    slidebuffer--;

if ((key_slap2 || keyboard_check_pressed(vk_escape)) && !instance_exists(obj_keyconfig) && !instance_exists(obj_audioconfig))
{
    fmod_event_one_shot("event:/sfx/enemies/projectile");
    
    if (menu == UnknownEnum.Value_0)
    {
        if (instance_exists(obj_mainmenuselect))
            obj_mainmenuselect.selected = false;
        
        instance_destroy();
    }
    else
    {
        menu_goto(menuids.categories);
    }
}
