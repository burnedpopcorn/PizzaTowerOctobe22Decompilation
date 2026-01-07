function cutscene_wait(arg0)
{
    timer++;
    
    if (timer >= arg0)
    {
        timer = 0;
        cutscene_end_action();
    }
}
