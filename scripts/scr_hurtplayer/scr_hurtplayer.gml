function scr_hurtplayer(arg0)
{
    var _obj = object_index;
    var _savedstate = arg0.state;
    var _hurt = false;
    
    with (arg0)
    {
        if (global.failcutscene)
        {
        }
        else if (state == states.supergrab || state == states.pizzaface_phase2transition || state == states.Parry || instance_exists(obj_vigilante_duelintro) || state == states.taxi || state == states.spaceshuttle || state == states.tube || state == states.debugstate || state == states.golf || state == states.slipbanan)
        {
        }
        else if (holycross > 0 || invtime > 0)
        {
        }
        else if (state == states.handstandjump && flash == true)
        {
        }
        else if (state == states.backbreaker || state == states.chainsaw || state == states.phase1hurt || state == states.actor || instance_exists(obj_bossdark))
        {
        }
        else if (global.kungfu)
        {
            if (state == states.blockstance)
            {
                if (sprite_index != spr_player_airattackstart)
                {
                    instance_create(x, y, obj_parryeffect);
                    image_index = 0;
                }
                
                sprite_index = spr_player_airattackstart;
                hsp = -xscale * 2;
            }
            else if (state != states.thrown && state != states.hit && !hurted)
            {
                instance_create(x, y, obj_parryeffect);
                
                repeat (5)
                {
                    with (create_debris(x, y, spr_slapstar))
                        vsp = irandom_range(-6, -11);
                }
                
                hitLag = 3;
                hitxscale = (x != other.x) ? sign(other.x - x) : -other.image_xscale;
                state = states.hit;
                hitstunned = 50;
                hurted = true;
                alarm[7] = hitstunned + 30;
                hithsp = 12;
                hitvsp = -5;
                hitX = x;
                hitY = y;
                sprite_index = spr_hurt;
                
                if (global.hp > 1)
                {
                    global.hp--;
                    
                    with (obj_camera)
                        healthshaketime = 60;
                }
                else
                {
                    with (obj_music)
                        arena = false;
                    
                    global.kungfu = false;
                    
                    if (!instance_exists(obj_fadeout))
                    {
                        with (obj_player)
                            targetRoom = lastroom;
                        
                        instance_create(x, y, obj_fadeout);
                    }
                }
            }
        }
        else if (isgustavo)
        {
            if (!hurted)
            {
                if (x != other.x)
                    xscale = sign(other.x - x);
                
                state = states.ratmounthurt;
                movespeed = 6;
                vsp = -9;
                flash = true;
                fmod_event_one_shot_3d("event:/sfx/pep/hurt", x, y);
                alarm[8] = 100;
                hurted = true;
                instance_create(x, y, obj_spikehurteffect);
                _hurt = true;
            }
        }
        else if (state == states.shotgundash)
        {
        }
        else if ((state == states.knightpep || state == states.knightpepattack || state == states.knightpepslopes || state == states.knightpepbump) && cutscene == false)
        {
        }
        else if (state == states.ghost)
        {
        }
        else if (state == states.ghostpossess)
        {
            if (instance_exists(possessID) && object_get_parent(possessID) == 555)
            {
                state = states.ghost;
                
                with (obj_baddie)
                {
                    if (is_controllable && state == states.ghostpossess && playerid == other.id)
                        instance_destroy();
                }
            }
        }
        else if (state == states.slipnslide)
        {
        }
        else if (state == states.trickjump)
        {
        }
        else if (state == states.chainsawbump)
        {
        }
        else if (state == states.bombpep && hurted == false)
        {
        }
        else if (state == states.rideweenie)
        {
        }
        else if (state == states.slipnslide)
        {
        }
        else if (state == states.boxxedpep)
        {
            hsp = -xscale * 4;
            vsp = -5;
            state = states.bump;
            sprite_index = spr_bump;
            alarm[5] = 2;
            alarm[8] = 60;
            alarm[7] = 120;
            hurted = true;
        }
        else if (pizzashield == true)
        {
            pizzashield = false;
            
            with (instance_create(x, y, obj_sausageman_dead))
                sprite_index = spr_pizzashield_collectible;
            
            hsp = -xscale * 4;
            vsp = -5;
            state = states.bump;
            sprite_index = spr_bump;
            invhurt_buffer = 120;
            alarm[8] = 60;
            alarm[7] = 120;
            hurted = true;
            fmod_event_one_shot_3d("event:/sfx/pep/hurt", x, y);
        }
        else if (state != states.hurt && state != states.ratmounthurt && state != states.grabbed && (hurted == false || state == states.cheesepep || state == states.cheesepepstickside || state == states.cheesepepstickup) && cutscene == false)
        {
            if (state == states.barrel || state == states.barrelclimbwall || state == states.barreljump || state == states.barrelslide)
            {
                repeat (4)
                    create_debris(x, y, spr_barreldebris);
            }
            
            var _old_xscale = xscale;
            
            if (x != other.x)
                xscale = sign(other.x - x);
            
            if (state == states.mort || state == states.morthook || state == states.mortjump || state == states.mortattack)
                create_debris(x, y - 40, spr_mortdead);
            
            if (instance_exists(obj_hardmode))
                global.heatmeter_count = (global.heatmeter_threshold - 1) * global.heatmeter_threshold_count;
            
            _hurt = true;
            pistolanim = -4;
            
            if (character == "V")
                global.playerhealth -= 25;
            
            if (global.kungfu)
            {
                if (global.hp > 1)
                {
                    global.hp--;
                    
                    with (obj_camera)
                        healthshaketime = 60;
                }
                else
                {
                    with (obj_music)
                        arena = false;
                    
                    global.kungfu = false;
                    
                    if (!instance_exists(obj_fadeout))
                    {
                        with (obj_player)
                            targetRoom = lastroom;
                        
                        instance_create(x, y, obj_fadeout);
                    }
                }
            }
            
            if (state == states.grabbed)
            {
                if (object_index == obj_player1)
                    y = obj_player2.y;
                else
                    y = obj_player1.y;
            }
            
            scr_sleep(100);
            fmod_event_one_shot_3d("event:/sfx/pep/hurt", x, y);
            instance_create(x, y, obj_bangeffect);
            alarm[8] = 100;
            alarm[7] = 150;
            hurted = true;
            
            if (xscale == -_old_xscale)
                sprite_index = spr_hurtjump;
            else
                sprite_index = spr_hurt;
            
            movespeed = 8;
            vsp = -14;
            timeuntilhpback = 300;
            pistolanim = -4;
            instance_create(x, y, obj_spikehurteffect);
            state = states.hurt;
            image_index = 0;
            flash = true;
            
            repeat (5)
                instance_create(x, y, obj_hurtstars);
        }
        
        if (_hurt)
        {
            notification_push(notifs.hurt_player, [arg0.id, _savedstate, _obj]);
            global.combotime -= 25;
            global.style -= 25;
            global.hurtcounter += 1;
            var loseamount = 50 * (global.stylethreshold + 1);
            
            if (!global.pizzadelivery)
            {
                global.collect -= loseamount;
                
                if (global.collect < 0)
                    global.collect = 0;
                
                if (global.collect != 0)
                {
                    if (character == "P" || character == "V")
                    {
                        repeat (10)
                        {
                            with (instance_create(x, y, obj_pizzaloss))
                                sprite_index = choose(spr_shroomcollect, spr_tomatocollect, spr_cheesecollect, spr_sausagecollect, spr_pineapplecollect);
                        }
                    }
                    else
                    {
                        repeat (10)
                            instance_create(x, y, obj_pizzaloss);
                    }
                }
            }
            
            with (obj_bosscontroller)
            {
                if (!instance_exists(obj_hpeffect))
                {
                    var pos = scr_bosscontroller_get_health_pos(player_hp, player_rowmax, player_columnmax, player_maxhp, player_hp_x, player_hp_y, player_xpad, player_ypad);
                    
                    with (instance_create(pos[0], pos[1], obj_sausageman_dead))
                    {
                        sprite_index = spr_bossfight_playerhp;
                        image_index = irandom(sprite_get_number(sprite_index) - 1);
                        hsp = 8;
                        vsp = -6;
                    }
                    
                    player_hp--;
                }
                else
                {
                    var d = instance_find(obj_hpeffect, instance_number(obj_hpeffect) - 1);
                    
                    with (instance_create(d.x, d.y, obj_sausageman_dead))
                    {
                        sprite_index = d.sprite_index;
                        hsp = (x < (room_width / 2)) ? 8 : -8;
                        vsp = -irandom_range(6, 8);
                    }
                    
                    instance_destroy(d);
                }
            }
        }
    }
}
