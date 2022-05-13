--  load lrc files

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function GetLrcPath(name)
  return name:gsub("(%..+)$", ".lrc")
end

function open_handler()
        lrcPath = GetLrcPath(mp.get_property("path"))
        if file_exists(lrcPath) then
            mp.set_property("options/sub-files", lrcPath)
        end
end
mp.register_event("start-file", open_handler)
