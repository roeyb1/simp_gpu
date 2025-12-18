Pool :: struct(Handle_Type: Type, Value_Type: Type) {
    values: [..] Value_Type;
    free_list: [..] s64;
}

pool_add :: (using pool: *Pool, item: pool.Value_Type) -> pool.Handle_Type {
    if free_list.count > 0 {
        index := pop(*free_list);
        values[index] = item;
        return (index + 1).(pool.Handle_Type);
    } else {
        array_add(*values, item);
        return values.count.(pool.Handle_Type);
    }
}

pool_remove :: (using pool: *Pool, handle: pool.Handle_Type) -> bool, pool.Value_Type {
    index := (handle - 1).(s64);
    assert(index >= 0 && index < values.count);
    array_add(*free_list, index);
    return true, values[index];
}

pool_get :: (using pool: Pool, handle: pool.Handle_Type) -> *pool.Value_Type {
    index := (handle - 1).(s64);
    assert(index >= 0 && index < values.count);
    return *values[index];
}