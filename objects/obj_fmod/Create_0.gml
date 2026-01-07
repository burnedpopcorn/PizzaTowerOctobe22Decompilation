fmod_init(32);
fmod_set_num_listeners(1);
var banks = ["sound/Desktop/Master.strings.bank", "sound/Desktop/Master.bank", "sound/Desktop/music.bank", "sound/Desktop/sfx.bank"];
trace("Loading banks!");

for (var i = 0; i < array_length(banks); i++)
{
    var b = working_directory + banks[i];
    
    if (!fmod_bank_load(b, false))
        trace("Could not load bank: ", b);
    else if (!fmod_bank_load_sample_data(b))
        trace("Could not load sample data: ", b);
}
