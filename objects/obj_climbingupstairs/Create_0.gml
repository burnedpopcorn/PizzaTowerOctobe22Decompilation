targetRoom = room;
targetDoor = "A";
image_speed = 0.4;
depth = 0;

with (obj_player)
{
    state = states.titlescreen;
    x = -obj_screensizer.actual_width - 100;
    y = -obj_screensizer.actual_height - 100;
}
