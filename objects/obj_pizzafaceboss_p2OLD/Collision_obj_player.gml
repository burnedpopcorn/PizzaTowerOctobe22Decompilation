if (other.state == states.knightpep && state == UnknownEnum.Value_238 && vsp > 0)
{
    scr_soundeffect(sfx_punch);
    hp--;
    other.state = states.normal;
    other.jumpstop = true;
    other.vsp = -11;
    state = states.normal;
}
