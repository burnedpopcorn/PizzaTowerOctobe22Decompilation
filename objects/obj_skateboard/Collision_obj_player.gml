if (other.state != states.chainsaw && other.skateboarding == false)
{
    instance_create(x, y, obj_genericpoofeffect);
    other.movespeed = 10;
    other.state = states.mach2;
    other.skateboarding = true;
    tv_push_prompt_once(tv_create_prompt("This is the clown transformation text", UnknownEnum.Value_2, 1440, 3), "skateboard");
}
