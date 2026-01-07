switch (state)
{
    case states.idle:
        scr_bee_idle();
        break;
    
    case UnknownEnum.Value_141:
        scr_bee_chase();
        break;
    
    case states.bee:
        scr_bee_bee();
        break;
    
    case states.hurt:
        scr_bee_hurt();
        break;
}
