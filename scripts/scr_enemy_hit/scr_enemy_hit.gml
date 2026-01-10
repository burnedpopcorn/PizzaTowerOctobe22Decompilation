function scr_enemy_hit()
{
    x = hitX + random_range(-6, 6);
    y = hitY + random_range(-6, 6);
    hitLag--;
    sprite_index = stunfallspr;
    
    if (object_index == obj_pepperman || object_index == obj_vigilanteboss || object_index == obj_noiseboss || object_index == obj_pf_fakepep || object_index == obj_fakepepboss || object_index == obj_pizzafaceboss)
    {
        if (player_instakillmove && pizzahead)
        {
            obj_player1.state = states.grab;
            obj_player1.sprite_index = obj_player1.spr_haulingstart;
            obj_player1.image_index = 0;
            obj_player1.baddiegrabbedID = id;
            state = states.grabbed;
            grabbedby = 1;
            x = hitX;
            y = hitY;
            exit;
        }
    }
    
    if (hitLag <= 0)
    {
        x = hitX;
        y = hitY;
        var _player = noone;
        
        if (grabbedby == 1)
            _player = obj_player1.id;
        else if (grabbedby == 2)
            _player = obj_player2.id;
        
        if ((obj_player.state == states.chainsaw && (obj_player.tauntstoredstate == states.mach2 || obj_player.tauntstoredstate == states.tumble)) || obj_player.state == states.mach2 || obj_player.state == states.tumble)
            thrown = false;
        else
            thrown = true;
        
        vsp = hitvsp;
        hsp = hithsp;
        global.hit += 1;
        
        if (other.object_index == obj_pizzaball)
            global.golfhit += 1;
        
        global.combotime = 60;
        global.heattime = 60;
        alarm[1] = 5;
        var _hp = 0;
        
        if ((global.attackstyle == 3 || global.attackstyle == 0) && !global.kungfu)
            _hp = -1;
        
        if (((!elite && (hp <= _hp || mach3destroy)) || (elite && (elitehit <= 0 || mach3destroy))) && object_get_parent(object_index) != 20 && object_index != obj_pizzafaceboss && destroyable && !mach2)
        {
            instance_destroy();
            instance_create(x, y, obj_genericpoofeffect);
        }
        
        if (object_index == obj_robot)
        {
            if (obj_player.tauntstoredstate == states.punch || obj_player.tauntstoredstate == states.freefall || obj_player.tauntstoredstate == states.superslam)
            {
                elitehit--;
                thrown = false;
                
                if (elitehit > 0)
                {
                    if (elitehit < 0)
                        elitehit = 0;
                    
                    event_perform(ev_destroy, 0);
                    var b = ds_list_find_index(global.baddieroom, id);
                    
                    if (b != -1)
                        ds_list_delete(global.baddieroom, b);
                }
                else
                {
                    instance_destroy();
                    instance_create(x, y, obj_genericpoofeffect);
                }
            }
        }
        
        stunned = 200;
        state = states.stun;
        
        if (object_index == obj_pepperman || object_index == obj_vigilanteboss || object_index == obj_noiseboss || object_index == obj_pf_fakepep || object_index == obj_fakepepboss || object_index == obj_pizzafaceboss)
        {
            if (obj_player.tauntstoredstate != states.punch && obj_player.tauntstoredstate != states.freefall && obj_player.tauntstoredstate != states.superslam)
            {
                linethrown = true;
                var f = 15;
                
                if (obj_player.tauntstoredstate == states.mach3)
                    f = 25;
                
                if (abs(hithsp) > abs(hitvsp))
                {
                    if (abs(hithsp) < f)
                        hithsp = sign(hithsp) * f;
                }
                else if (abs(hitvsp) < f)
                {
                    hitvsp = sign(hitvsp) * f;
                }
            }
            else if (!pizzahead)
            {
                elitehit--;
                
                if (elitehit < 0)
                    elitehit = 0;
                
                event_perform(ev_destroy, 0);
                var b = ds_list_find_index(global.baddieroom, id);
                
                if (b != -1)
                    ds_list_delete(global.baddieroom, b);
                
                hsp = 8 * -image_xscale;
                vsp = -6;
                flash = false;
                state = states.walk;
                
                if (object_index == obj_pepperman)
                    sprite_index = spr_pepperman_scared;
            }
            
            if (obj_player.tauntstoredstate == states.mach2 || obj_player.tauntstoredstate == states.tumble || obj_player.state == states.mach2 || obj_player.state == states.tumble)
                stunned *= 5;
        }
        
        if (mach2)
            thrown = false;
        
        mach2 = false;
    }
}
