direction = angle_rotate(direction, point_direction(x, y, player.x, player.y), 2);
count++;
image_angle = direction;
speed = Approach(speed, 4, 0.2);

if (sprite_index == spr_piraneapple_projectile && image_angle > 90)
    image_yscale = -1;
else
    image_yscale = 1;
