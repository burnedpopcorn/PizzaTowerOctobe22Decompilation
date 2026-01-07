if (playerid.visible == false)
{
    jumpbuffer = 15;
    start = true;
    
    with (obj_player1)
    {
        fmod_event_one_shot("event:/sfx/misc/taxibeep");
        
        if (isgustavo)
            state = states.ratmount;
        else
            state = states.normal;
        
        instance_create(x, y, obj_genericpoofeffect);
        cutscene = false;
    }
    
    if (global.coop == true)
    {
        with (obj_player2)
        {
            state = states.normal;
            cutscene = false;
        }
    }
    
    obj_player1.visible = true;
    obj_player2.visible = true;
}
