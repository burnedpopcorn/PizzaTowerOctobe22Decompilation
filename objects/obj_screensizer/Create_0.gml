enum aspectratio
{
	normal = 0,
	alt = 1,
}
global.resolutions[aspectratio.normal] = 
[
	[480, 270], [960, 540], 
	[1024, 576], [1280, 720], 
	[1600, 900], [1920, 1080]
];
global.resolutions[aspectratio.alt] = 
[
	[640, 480], [800, 600], 
	[1024, 768], [1152, 864], 
	[1440, 1080]
];
start_sound = false;
get_options();
normal_size_fix_x = 0;
normal_size_fix_y = 0;
app_scale = 1;
display_width = display_get_width();
display_height = display_get_height();
aspect_ratio = aspectratio.normal;
gui_surf = noone;
ideal_width = get_resolution_width(1, aspect_ratio);
ideal_height = get_resolution_height(1, aspect_ratio);
actual_width = ideal_width;
actual_height = ideal_height;
window_width_current = 0;
window_height_current = 0;
last_scale_mode = global.option_scale_mode;
last_fullscreen = false;
alarm[1] = 1;
application_surface_draw_enable(false);
display_set_gui_size(CAMERA_WIDTH, CAMERA_HEIGHT);
screen_apply_size();
