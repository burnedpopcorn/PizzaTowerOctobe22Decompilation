depth = 1;
global.afterimage_list = ds_list_create();
alpha = array_create(UnknownEnum.Value_7, 1);
alpha[UnknownEnum.Value_2] = 0.5;
shd_alpha = shader_get_uniform(shd_firemouth_afterimage, "newAlpha");
shd_color_red = shader_get_uniform(shd_color_afterimage, "red");
shd_color_green = shader_get_uniform(shd_color_afterimage, "green");
shd_color_blue = shader_get_uniform(shd_color_afterimage, "blue");
