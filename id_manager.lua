local storage = mega_mitts.storage

local function get_freed_ids()
    return minetest.deserialize(storage:get_string("freed_ids")) or {}
end

local function get_highest_id()
    return tonumber(storage:get_string("highest_id")) or 0

end

mega_mitts.id_manager = {
    get_next_id = function()
        local next_id
        local freed_ids = get_freed_ids()
        if #freed_ids > 0 then
            next_id = table.remove(freed_ids)
            storage:set_string("freed_ids", minetest.serialize(freed_ids))
        else
            highest_id = get_highest_id() + 1
            next_id = highest_id
            storage:set_string("highest_id", tostring(highest_id))
        end
        return next_id
    end,

    release_id = function(id)
        local freed_ids = get_freed_ids()
        table.insert(freed_ids, id)
        storage:set_string("freed_ids", minetest.serialize(freed_ids))
    end,
}




