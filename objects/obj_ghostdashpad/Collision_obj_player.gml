with (other)
{
    if (state == states.ghost && other.visible == true)
    {
        ghostdash = true;
        
        if (xscale > 0)
            ghostangle = 0;
        else
            ghostangle = 180;
        
        ghostpepper += 1;
        other.cooldown = 50;
        other.visible = false;
        
        repeat (2)
            create_debris(other.x, other.y, spr_flashdots, true);
    }
}
