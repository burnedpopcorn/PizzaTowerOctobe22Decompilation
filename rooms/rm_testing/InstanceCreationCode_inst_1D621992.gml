trigger = 7;

func = function(arg0)
{
    if (!active)
    {
        if (following_count(332) >= 3)
        {
            active = true;
            instance_destroy(obj_chickenfollow);
        }
    }
};
