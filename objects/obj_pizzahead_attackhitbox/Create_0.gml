event_inherited();
dmg = 30;
parryable = true;

boss_parry_hitbox = function(arg0, arg1)
{
    if (!arg1.collisioned)
    {
        SUPER_parry();
        
        with (obj_pizzafaceboss)
            SUPER_boss_hurt(30, arg0);
        
        with (arg1)
            event_user(0);
    }
};
