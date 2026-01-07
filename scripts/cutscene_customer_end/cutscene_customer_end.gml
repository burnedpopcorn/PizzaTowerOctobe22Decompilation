function cutscene_customer_check(arg0, arg1, arg2)
{
    with (obj_gnome_checklist)
        gnome_check[arg0] = true;
    
    global.pizzasdelivered++;
    
    if (instance_exists(obj_gnomecustomerblock))
        instance_destroy(obj_gnomecustomerblock);
    
    with (instance_create(arg1.x, arg1.y, obj_pizzaboxunopen))
    {
        content = arg2.content;
        depth = arg1.depth;
        visible = false;
    }
    
    ds_list_add(global.saveroom, arg2.id);
    cutscene_end_action();
}

function cutscene_customer_end(arg0)
{
    with (obj_customeractor)
        happy = true;
    
    cutscene_end_action();
}
