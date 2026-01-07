function totem_empty(arg0)
{
    with (arg0)
    {
        for (var i = 0; i < array_length(cheeseID); i++)
        {
            if (cheeseID[i] == noone)
                return true;
        }
        
        return false;
    }
}

function totem_add(arg0, arg1)
{
    with (arg0)
    {
        for (var i = 0; i < array_length(cheeseID); i++)
        {
            if (cheeseID[i] == noone)
            {
                cheeseID[i] = arg1;
                return true;
            }
        }
        
        return false;
    }
}

function totem_clear(arg0)
{
    with (arg0)
    {
        for (var i = 0; i < array_length(cheeseID); i++)
        {
            if (cheeseID[i] != noone && (!instance_exists(cheeseID[i]) || cheeseID[i].state != UnknownEnum.Value_188))
            {
                if (instance_exists(cheeseID[i]))
                    cheeseID[i].totemID = noone;
                
                cheeseID[i] = noone;
            }
        }
    }
}

function totem_count(arg0)
{
    var c = 0;
    
    with (arg0)
    {
        for (var i = 0; i < array_length(cheeseID); i++)
        {
            if (cheeseID[i] != noone)
                c++;
        }
        
        return c;
    }
}
