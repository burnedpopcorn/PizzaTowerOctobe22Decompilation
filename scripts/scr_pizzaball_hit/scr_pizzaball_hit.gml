function scr_pizzaball_hit()
{
    x = hitX + irandom_range(-6, 6);
    y = hitY + irandom_range(-6, 6);
    hitLag--;
    sprite_index = stunfallspr;
    
    if (hitLag <= 0)
    {
        x = hitX;
        y = hitY;
        var s = -1;
        
        with (instance_nearest(x, y, obj_player))
            s = tauntstoredstate;
        
        notification_push(notifications.special_destroyable_destroyed, [464]);
        
        if (s != UnknownEnum.Value_104)
            scr_pizzaball_go_to_thrown(hithsp * 1.5, -12);
        else
            scr_pizzaball_go_to_thrown(hithsp * 0.5, hitvsp * 0.5);
        
        global.golfhit++;
    }
}

function scr_pizzaball_grabbed()
{
    var pl = (grabbedby == 1) ? obj_player1 : obj_player2;
    
    with (pl)
    {
        sprite_index = spr_golfidle;
        image_index = 0;
        state = states.golf;
        golfid = other.id;
        hsp = 0;
        vsp = 0;
    }
    
    player = pl;
    state = states.golf;
    create_transformation_tip(lang_get_value("golftip"), "golf");
}

function scr_pizzaball_go_to_thrown(arg0, arg1, arg2 = true)
{
    hitspeed = abs(arg0);
    
    if (sign(arg0) != 0)
        image_xscale = sign(arg0);
    
    jumpspeed = abs(arg1);
    
    if (arg2 && jumpspeed < 12)
        jumpspeed = 12;
    
    vsp = -jumpspeed;
    bounced = false;
    state = states.thrown;
    substate = states.thrown;
}
