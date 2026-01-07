if (instance_exists(other.baddieID) && other.baddieID.thrown)
{
    instance_destroy(other.baddieID);
    hp--;
    scr_soundeffect(sfx_punch);
}
