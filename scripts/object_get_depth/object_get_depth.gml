function object_get_depth(arg0)
{
    var objID = arg0;
    var ret = 0;
    
    if (objID >= obj_bossdoor && objID < array_length_1d(global.__objectID2Depth))
        ret = global.__objectID2Depth[objID];
    
    return ret;
}
