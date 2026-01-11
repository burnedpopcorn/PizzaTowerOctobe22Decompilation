function scr_pistolshoot(_state)
{
    if ((pistolcooldown <= 0 && state == _state && instance_number(obj_pistolbullet) < 3) || pistolchargeshooting == true)
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
        
        if (_state == states.mach3 || _state == states.mach2)
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
