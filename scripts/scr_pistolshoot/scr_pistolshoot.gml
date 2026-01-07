function scr_pistolshoot(arg0)
{
    if ((pistolcooldown <= 0 && state == arg0 && instance_number(obj_pistolbullet) < 3) || pistolchargeshooting == true)
    {
        input_buffer_shoot = 0;
        pistolanim = spr_pistolshot;
        pistolindex = 0;
        pistolcooldown = 10;
        machslideAnim = false;
        landAnim = false;
        jumpAnim = false;
        crouchslideAnim = false;
        crouchAnim = false;
        stompAnim = false;
        
        if (arg0 == UnknownEnum.Value_121 || arg0 == UnknownEnum.Value_104)
            state = states.normal;
        
        windingAnim = 0;
        
        with (instance_create(x + (xscale * 35), y, obj_parryeffect))
        {
            sprite_index = spr_player_pistoleffect;
            image_xscale = other.xscale;
            image_speed = 0.4;
        }
        
        fmod_event_one_shot_3d("event:/sfx/enemies/killingblow", x + (xscale * 20), y);
        
        with (instance_create(x + (xscale * 20), y, obj_pistolbullet))
            image_xscale = other.xscale;
    }
}
