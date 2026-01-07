dialog[0] = dialog_create("This is a test for dialog", 3022);
dialog[1] = dialog_create("This is a really long text to test out how well it separates the text in chunks for it to be readable", 3022, function()
{
    dialog = -4;
    dialog[0] = dialog_create("This is a test for new conversation after the end of one");
});
