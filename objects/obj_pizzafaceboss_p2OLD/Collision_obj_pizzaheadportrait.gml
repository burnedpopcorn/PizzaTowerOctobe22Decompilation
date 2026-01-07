if (other.thrown)
{
    instance_destroy(other);
    hp--;
    scr_soundeffect(sfx_punch);
}
