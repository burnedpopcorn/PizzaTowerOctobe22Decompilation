function scr_keyname(_key)
{
    switch (_key)
    {
        case vk_up:
            return "UP";
            break;
        
        case vk_right:
            return "RIGHT";
            break;
        
        case vk_left:
            return "LEFT";
            break;
        
        case vk_down:
            return "DOWN";
            break;
        
        case vk_enter:
            return "ENTER";
            break;
        
        case vk_escape:
            return "ESCAPE";
            break;
        
        case vk_space:
            return "SPACE";
            break;
        
        case vk_rshift:
            return "SHIFT";
            break;
        
        case vk_lshift:
            return "SHIFT";
            break;
        
        case vk_shift:
            return "SHIFT";
            break;
        
        case vk_control:
            return "CONTROL";
            break;
        
        case vk_lcontrol:
            return "CONTROL";
            break;
        
        case vk_rcontrol:
            return "CONTROL";
            break;
        
        case vk_alt:
            return "ALT";
            break;
        
        case vk_lalt:
            return "ALT";
            break;
        
        case vk_backspace:
            return "BACKSPACE";
            break;
        
        case vk_tab:
            return "TAB";
            break;
        
        case vk_home:
            return "HOME";
            break;
        
        case vk_end:
            return "END";
            break;
        
        case vk_delete:
            return "DELETE";
            break;
        
        case vk_insert:
            return "INSERT";
            break;
        
        case vk_pageup:
            return "PAGE UP";
            break;
        
        case vk_pagedown:
            return "PAGE DOWN";
            break;
        
        case vk_pause:
            return "PAUSE";
            break;
        
        case vk_printscreen:
            return "PRINTSCREEN";
            break;
        
        case 112:
            return "F1";
            break;
        
        case 113:
            return "F2";
            break;
        
        case 114:
            return "F3";
            break;
        
        case 115:
            return "F4";
            break;
        
        case 116:
            return "F5";
            break;
        
        case 117:
            return "F6";
            break;
        
        case 118:
            return "F7";
            break;
        
        case 119:
            return "F8";
            break;
        
        case 120:
            return "F9";
            break;
        
        case 121:
            return "F10";
            break;
        
        case 122:
            return "F11";
            break;
        
        case 123:
            return "F12";
            break;
        
        case 96:
            return "NUMPAD 0";
            break;
        
        case 97:
            return "NUMPAD 1";
            break;
        
        case 98:
            return "NUMPAD 2";
            break;
        
        case 99:
            return "NUMPAD 3";
            break;
        
        case 100:
            return "NUMPAD 4";
            break;
        
        case 101:
            return "NUMPAD 5";
            break;
        
        case 102:
            return "NUMPAD 6";
            break;
        
        case 103:
            return "NUMPAD 7";
            break;
        
        case 104:
            return "NUMPAD 8";
            break;
        
        case 105:
            return "NUMPAD 9";
            break;
        
        case 106:
            return "MULTIPLY";
            break;
        
        case 111:
            return "DIVIDE";
            break;
        
        case 107:
            return "ADD";
            break;
        
        case 109:
            return "SUBTRACT";
            break;
        
        case 110:
            return "DECIMAL";
            break;
        
        case -1:
            return "PRESS KEY";
            break;
    }
    
    return chr(_key);
}
