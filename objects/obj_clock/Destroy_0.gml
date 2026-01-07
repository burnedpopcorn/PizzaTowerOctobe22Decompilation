create_particle(x, y, particle.genericpoofeffect);
audio_stop_sound(sfx_timercount);
fmod_event_one_shot("event:/sfx/misc/timerend");
