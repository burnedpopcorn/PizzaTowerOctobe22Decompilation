if (hurted == false && other.grounded == false && other.team == 0 && state != states.backbreaker && state != states.Parry)
{
    instance_destroy(other);
    instance_create(x, y, obj_canonexplosion);
}
