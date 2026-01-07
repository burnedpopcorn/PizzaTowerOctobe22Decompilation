if (global.panic && !instance_exists(ID))
{
    with (instance_create(x + (sprite_width / 2), y + (sprite_height / 2), obj_pineapplemonster))
    {
        monster = other.monster;
        content = other.content;
        other.ID = id;
    }
    
    instance_destroy();
}
