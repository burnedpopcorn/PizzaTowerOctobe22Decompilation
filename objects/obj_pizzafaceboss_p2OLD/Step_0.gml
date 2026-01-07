wastedhits = maxhp - hp;
targetplayer = obj_player1;
image_speed = 0.35;

switch (state)
{
    case states.fall:
        scr_pizzaface_p2_fall();
        break;
    
    case states.normal:
        scr_pizzaface_p2_normal();
        break;
    
    case states.pizzahead_look:
        scr_pizzaface_p2_look();
        break;
    
    case states.pizzahead_fishing:
        scr_pizzaface_p2_fishing();
        break;
    
    case UnknownEnum.Value_235:
        boss_pizzahead_bombrun();
        break;
    
    case UnknownEnum.Value_236:
        boss_pizzahead_npcthrow();
        break;
    
    case UnknownEnum.Value_237:
        boss_pizzahead_portraitthrow();
        break;
    
    case UnknownEnum.Value_238:
        boss_pizzahead_enguarde();
        break;
    
    case UnknownEnum.Value_239:
        boss_pizzahead_sexypicture();
        break;
    
    case UnknownEnum.Value_240:
        boss_pizzahead_pullinglevel();
        break;
    
    case UnknownEnum.Value_241:
        boss_pizzahead_eat();
        break;
    
    case UnknownEnum.Value_242:
        boss_pizzahead_surprisebox();
        break;
}

if (place_meeting(x, y, obj_canonexplosion))
{
    if (!explosionhit)
    {
        explosionhit = true;
        hp--;
        scr_soundeffect(sfx_punch);
    }
}
else
{
    explosionhit = false;
}

if (hp <= 0 && !instance_exists(obj_fadeout))
{
    with (obj_player)
    {
        targetRoom = boss_pizzaface_p3;
        targetDoor = "A";
    }
    
    instance_create(0, 0, obj_fadeout);
}

scr_collide();
