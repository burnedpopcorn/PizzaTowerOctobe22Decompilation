if (instance_number(object_index) > 1)
{
    instance_destroy();
    exit;
}

achievements_update = [];
achievements_notify = [];
notify_queue = ds_queue_create();

add_secrets_achievement(1, ["entrance", "medieval", "ruin", "dungeon"]);
add_secrets_achievement(2, ["badland", "graveyard", "saloon", "farm"]);
add_secrets_achievement(3, ["plage", "forest", "space", "minigolf"]);
add_secrets_achievement(4, ["street", "sewer", "industrial", "freezer"]);
add_secrets_achievement(5, ["chateau", "kidsparty"]);

// NOTE: Some levels are missing
// because they weren't finished in this build

// Floor 2
#region Fun Farm
add_achievement_notify("farm1", function()
{
    achievement_add_variable("f1_count", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (type == notifs.room_enemiesdead)
    {
        var n = achievement_get_variable("f1_count");
        var r = room_get_name(arr[1]);
        
        if (obj_player.state == states.backbreaker && (string_letters(r) == "farm" || string_letters(r) == "farmb"))
        {
            n.value++;
            
            if (n.value >= 3)
                achievement_unlock(name, "No one is safe", spr_achievement_farm, 2);
        }
    }
});
add_achievement_notify("farm2", noone, function(_data)
{
    var type = _data[0];
    
    if (type == notifs.mortcube_destroyed)
        achievement_unlock(name, "Cube Menace", spr_achievement_farm, 1);
});
add_achievement_notify("farm3", function()
{
    achievement_add_variable("f3_hurted", false, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if ((type == notifs.hurt_player || type == notifs.fell_into_pit) && (arr[1] == states.mort || arr[1] == states.morthook || arr[1] == states.mortattack || arr[1] == states.mortjump))
        achievement_get_variable("f3_hurted").value = true;
    
    if (type == notifs.level_finished && arr[0] == "farm" && !achievement_get_variable("f3_hurted").value)
        achievement_unlock(name, "Good Egg", spr_achievement_farm, 0);
});
#endregion
#region Fast Food Saloon
add_achievement_notify("saloon1", function()
{
    achievement_add_variable("s1_beer", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    
    if (type == notifs.beer_knocked && global.leveltosave == "saloon")
    {
        achievement_get_variable("s1_beer").value += 1;
        
        if (achievement_get_variable("s1_beer").value >= 73)
            achievement_unlock(name, "Non-Alcoholic", spr_achievement_saloon, 0);
    }
});
add_achievement_notify("saloon2", function()
{
    achievement_add_variable("s2_count", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    
    if (type == notifs.touched_timedgate && global.leveltosave == "saloon")
        achievement_get_variable("s2_count").value += 1;
    else if (type == notifs.level_finished)
    {
        var arr = _data[1];
        
        if (arr[0] == "saloon" && achievement_get_variable("s2_count").value == 9)
            achievement_unlock(name, "Already Pressed", spr_achievement_saloon, 1);
    }
});
add_achievement_notify("saloon3", function()
{
    achievement_add_variable("s3_count", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    
    if (type == notifs.flush_done && global.leveltosave == "saloon")
    {
        achievement_get_variable("s3_count").value += 1;
        
        if (achievement_get_variable("s3_count").value >= 12)
            achievement_unlock(name, "Royal Flush", spr_achievement_saloon, 2);
    }
});
#endregion
// Floor 3
#region Crust Cove
add_achievement_notify("beach1", function() { }, function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (type == notifs.baddie_killed_projectile && global.leveltosave == "plage" && arr[1] == obj_canongoblin && arr[3] == obj_canongoblinbomb)
        achievement_unlock(name, "Blowback", spr_achievement_beach, 0);
});
add_achievement_notify("beach2", function()
{
    achievement_add_variable("b2_count", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (type == notifs.treasureguy_uncovered && global.leveltosave == "plage" && arr[1] == obj_treasureguy)
    {
        achievement_get_variable("b2_count").value += 1;
        
        if (achievement_get_variable("b2_count").value >= 6)
            achievement_unlock(name, "X Marks The Spot", spr_achievement_beach, 1);
    }
});
add_achievement_notify("beach3", function()
{
    achievement_add_variable("b3_hurt", false, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (type == notifs.hurt_player && global.leveltosave == "plage" && arr[2] == obj_canonexplosion)
        achievement_get_variable("b3_hurt").value = true;
    else if (type == notifs.level_finished && arr[0] == "plage" && achievement_get_variable("b3_hurt").value == false)
        achievement_unlock(name, "Demolition Expert", spr_achievement_beach, 2);
});
#endregion
#region Gnome Forest
add_achievement_update("forest1", 5, noone, function()
{
    if (global.leveltosave == "forest")
    {
        var b = false;
        
        with (obj_player)
        {
            if (!b && state == states.backbreaker && distance_to_object(obj_beedeco) < 300)
                b = true;
        }
        
        if (b)
            achievement_unlock(name, "Bee Nice", spr_achievement_forest, 0);
    }
});
add_achievement_notify("forest2", function()
{
    achievement_add_variable("fo2_count", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (type == notifs.special_destroyable_destroyed && global.leveltosave == "forest" && (arr[0] == obj_smallforestblock || arr[0] == obj_bigforestblock))
    {
        achievement_get_variable("fo2_count").value += 1;
        
        if (achievement_get_variable("fo2_count").value >= 181)
            achievement_unlock(name, "Lumberjack", spr_achievement_forest, 1);
    }
});
add_achievement_notify("forest3", function() { }, function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (type == notifs.baddie_killed_projectile && global.leveltosave == "forest" && arr[1] == obj_noisegoblin && arr[3] == obj_noisegoblin_arrow)
        achievement_unlock(name, "Bullseye", spr_achievement_forest, 2);
});
#endregion
#region Deep Dish 9
add_achievement_update("space1", 1, function()
{
    achievement_add_variable("sp1_hit", false, false, true);
}, 
function()
{
    if (room == space_10)
    {
        var b = false;
        
        with (obj_antigravbubble)
        {
            if (sprite_index == spr_antigrav_bubblesquish)
                b = true;
        }
        
        if (b)
            achievement_get_variable("sp1_hit").value = true;
    }
    else if (room == space_11 && achievement_get_variable("sp1_hit").value == false)
        achievement_unlock(name, "Turbo Tunnel", spr_achievement_space, 0);
});
add_achievement_notify("space2", function()
{
    achievement_add_variable("sp2_count", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (type == notifs.special_destroyable_destroyed && global.leveltosave == "space" && arr[0] == obj_asteroid)
    {
        achievement_get_variable("sp2_count").value += 1;
        
        if (achievement_get_variable("sp2_count").value >= 17)
            achievement_unlock(name, "Blast Em Asteroids", spr_achievement_space, 2);
    }
});
add_achievement_notify("space3", function()
{
    achievement_add_variable("sp3_count", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (type == notifs.custom_destructibles_destroyed && (arr[0] == obj_secretmetalblock || arr[0] == obj_whoophand))
    {
        achievement_get_variable("sp3_count").value += 1;
        
        if (achievement_get_variable("sp3_count").value >= 2)
            achievement_unlock(name, "Man Meteor", spr_achievement_space, 1);
    }
});
#endregion
#region GOLF
add_achievement_notify("golf1", function()
{
    achievement_add_variable("g1_count", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (type == notifs.pizzaball_goal && arr[0] == spr_pizzaball_rank1)
    {
        achievement_get_variable("g1_count").value += 1;
        
        if (achievement_get_variable("g1_count").value >= 9)
            achievement_unlock(name, "Primo Golfer", spr_achievement_golf, 0);
    }
});
add_achievement_notify("golf2", function()
{
    achievement_add_variable("g2_count", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (type == notifs.pizzaball_shot && (arr[0] == obj_player1 || arr[0] == obj_player1))//are we being so cereal rn
        achievement_get_variable("g2_count").value = 0;
    else if (type == notifs.pizzaball_kill)
    {
        achievement_get_variable("g2_count").value += 1;
        
        if (achievement_get_variable("g2_count").value >= 3)
            achievement_unlock(name, "Nice Shot", spr_achievement_golf, 1);
    }
});
add_achievement_notify("golf3", function()
{
    achievement_add_variable("g3_hit", false, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (type == notifs.pizzaball_shot)
    {
        if (arr[0] == obj_golfburger)
            achievement_get_variable("g3_hit").value = true;
        else
            achievement_get_variable("g3_hit").value = false;
    }
    else if (type == notifs.pizzaball_goal && achievement_get_variable("g3_hit").value == true)
        achievement_unlock(name, "Helpful Burger", spr_achievement_golf, 2);
});
#endregion
// Floor 4
#region Pig City
add_achievement_update("street1", 60, noone, function()
{
    if (room == street_bacon)
        achievement_unlock(name, "Pan Fried", spr_achievement_street, 0);
});
add_achievement_notify("street2", function()
{
    achievement_add_variable("st2_count", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    
    if (type == notifs.brickball_start)
        achievement_get_variable("st2_count").value = 0;
    else if (type == notifs.brickball_kill)
    {
        achievement_get_variable("st2_count").value += 1;
        
        if (achievement_get_variable("st2_count").value >= 3)
            achievement_unlock(name, "Strike!", spr_achievement_street, 1);
    }
});
add_achievement_notify("street3", function()
{
    achievement_add_variable("st3_count", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    
    if (type == notifs.pigcitizen_taunt)
    {
        achievement_get_variable("st3_count").value += 1;
        
        if (achievement_get_variable("st3_count").value >= 15)
            achievement_unlock(name, "Say Oink!", spr_achievement_street, 2);
    }
});
#endregion
#region Oh Shit!
add_achievement_notify("sewer1", function()
{
    achievement_add_variable("sw1_killed", false, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (type == notifs.pizzaboy_killed)
        achievement_get_variable("sw1_killed").value = true;
    else if (type == notifs.level_finished && arr[0] == "sewer" && achievement_get_variable("sw1_killed").value == false)
        achievement_unlock(name, "Can't Fool Me", spr_achievement_sewer, 0);
});
add_achievement_notify("sewer2", function()
{
    achievement_add_variable("sw2_count", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (global.leveltosave == "sewer" && type == notifs.enemy_parried && arr[1] == obj_ninja)
    {
        achievement_get_variable("sw2_count").value += 1;
        
        if (achievement_get_variable("sw2_count").value >= 10)
            achievement_unlock(name, "Food Clan", spr_achievement_sewer, 1);
    }
});
add_achievement_notify("sewer3", function()
{
    achievement_add_variable("sw3_count", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (global.leveltosave == "sewer" && type == notifs.touched_mrpinch)
        achievement_get_variable("sw3_count").value += 1;
    else if (type == notifs.level_finished && arr[0] == "sewer" && achievement_get_variable("sw3_count").value <= 13)
        achievement_unlock(name, "Penny Pincher", spr_achievement_sewer, 2);
});
#endregion
#region PeppiBot Factory
add_achievement_notify("industrial1", function()
{
    achievement_add_variable("i1_count", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (global.leveltosave == "industrial" && type == notifs.priest_touched && (arr[2] == states.boxxedpep || arr[2] == states.boxxedpepjump || arr[2] == states.boxxedpepspin))
    {
        achievement_get_variable("i1_count").value += 1;
        
        if (achievement_get_variable("i1_count").value >= 3)
            achievement_unlock(name, "Unflattenning", spr_achievement_industrial, 0);
    }
});
add_achievement_notify("industrial2", function()
{
    achievement_add_variable("i2_count", 0, false, true);
    achievement_add_variable("i2_hurt", false, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (room == industrial_secret1)
    {
        if (type == notifs.generic_killed && arr[2] == obj_sausageman)
            achievement_get_variable("i2_count").value += 1;
        else if (type == notifs.hurt_player)
            achievement_get_variable("i2_hurt").value = true;
    }
    
    if (type == notifs.secret_exited && arr[0] == industrial_secret1 && achievement_get_variable("i2_hurt").value == false && achievement_get_variable("i2_count").value >= 13)
        achievement_unlock(name, "Whoop This", spr_achievement_industrial, 1);
});
add_achievement_notify("industrial3", function()
{
    achievement_add_variable("i3_count", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (global.leveltosave == "industrial" && type == notifs.generic_killed && arr[2] == obj_robot)
    {
        achievement_get_variable("i3_count").value += 1;
        
        if (achievement_get_variable("i3_count").value >= 33)
            achievement_unlock(name, "There Can Be Only One", spr_achievement_industrial, 2);
    }
});
#endregion
#region RRF
add_achievement_notify("freezer1", function()
{
    achievement_add_variable("fr1_count", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    
    if (global.leveltosave == "freezer" && type == notifs.destroy_iceblock)
    {
        achievement_get_variable("fr1_count").value += 1;
        
        if (achievement_get_variable("fr1_count").value >= 12)
            achievement_unlock(name, "Frozen Nuggets", spr_achievement_freezer, 0);
    }
});
add_achievement_notify("freezer2", function()
{
    achievement_add_variable("fr2_count", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (global.leveltosave == "freezer" && type == notifs.generic_killed && arr[2] == obj_fakesanta)
    {
        achievement_get_variable("fr2_count").value += 1;
        
        if (achievement_get_variable("fr2_count").value >= 6)
            achievement_unlock(name, "Frozen Nuggets", spr_achievement_freezer, 1);
    }
});
add_achievement_notify("freezer3", function()
{
    achievement_add_variable("fr3_fall", false, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (type == notifs.fell_into_pit && global.leveltosave == "freezer")
        achievement_get_variable("fr3_fall").value = true;
    else if (type == notifs.level_finished && arr[0] == "freezer" && achievement_get_variable("fr3_fall").value == false)
        achievement_unlock(name, "Ice Climber", spr_achievement_freezer, 2);
});
#endregion
// Floor 5
#region PizzaScare
add_achievement_notify("chateau1", function()
{
    achievement_add_variable("ch1_count", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (global.leveltosave == "chateau" && type == notifs.generic_killed && arr[2] == obj_ghostknight)
    {
        achievement_get_variable("ch1_count").value += 1;
        
        if (achievement_get_variable("ch1_count").value >= 40)
            achievement_unlock(name, "Cross To Bare", spr_achievement_chateau, 0);
    }
});
add_achievement_notify("chateau2", function()
{
    achievement_add_variable("ch2_hurt", false, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (type == notifs.hurt_player && (arr[2] == obj_anchortrap || arr[2] == obj_knighttrap))
        achievement_get_variable("ch2_hurt").value = true;
    
    if (type == notifs.level_finished && arr[0] == "chateau" && !achievement_get_variable("ch2_hurt").value)
        achievement_unlock(name, "Haunted Playground", spr_achievement_chateau, 1);
});
add_achievement_notify("chateau3", function()
{
    achievement_add_variable("ch3_count", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    
    if (type == notifs.custom_destructibles_destroyed && global.leveltosave == "chateau")
    {
        achievement_get_variable("ch3_count").value += 1;
        
        if (achievement_get_variable("ch3_count").value >= 10)
            achievement_unlock(name, "Skullsplitter", spr_achievement_chateau, 2);
    }
});
#endregion
#region Dont Make A Sound
add_achievement_notify("kidsparty1", function()
{
    achievement_add_variable("kp1_count", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    
    if (type == notifs.monster_dead && global.leveltosave == "kidsparty")
    {
        achievement_get_variable("kp1_count").value += 1;
        
        if (achievement_get_variable("kp1_count").value >= 9)
            achievement_unlock(name, "And This... Is My Gun-On-A-Stick!", spr_achievement_industrial, 0);
    }
});
add_achievement_notify("kidsparty2", function()
{
    achievement_add_variable("kp2_count", 0, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (type == notifs.monster_activate && global.leveltosave == "kidsparty")
        achievement_get_variable("kp2_count").value += 1;
    else if (type == notifs.level_finished && arr[0] == "kidsparty")
    {
        if (achievement_get_variable("kp2_count").value <= 14)
            achievement_unlock(name, "Let Them Sleep", spr_achievement_industrial, 1);
    }
});
add_achievement_notify("kidsparty3", function()
{
    achievement_add_variable("kp3_hurted", false, false, true);
}, 
function(_data)
{
    var type = _data[0];
    var arr = _data[1];
    
    if (type == notifs.monster_jumpscare && global.leveltosave == "kidsparty")
        achievement_get_variable("kp3_hurted").value = true;
    else if (type == notifs.level_finished && arr[0] == "kidsparty")
    {
        if (achievement_get_variable("kp3_hurted").value == false)
            achievement_unlock(name, "Jumpspared", spr_achievement_industrial, 2);
    }
});
#endregion