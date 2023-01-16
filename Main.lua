 rconsoleclear()
rconsolename("XenjiosScripts| Press Enter button to continue")
rconsoleinput()




local name = "XenijoScripts"
local files = {
    "https://raw.githubusercontent.com/Xenijo/XenWare-OpenScource/main/Anime%20Hero%20Script.lua",
    "https://raw.githubusercontent.com/Xenijo/XenWare-OpenScource/main/AnimeClicker.lua",
    "https://raw.githubusercontent.com/Xenijo/XenWare-OpenScource/main/Da-Hood-Modded-XenWare.lua",
    "https://raw.githubusercontent.com/Xenijo/XenWare-OpenScource/main/Silent%20Aim.lua",
    "https://raw.githubusercontent.com/Xenijo/XenWare-OpenScource/main/Speed.lua",
    "https://raw.githubusercontent.com/Xenijo/XenWare-OpenScource/main/XenWareV2.lua"
}

if not isfolder(name) then 
    makefolder(name)
end

for i = 1, #files do
    local url = files[i]
    local fileName = url:match("([^/]+)$")
    if fileName then
        local filepath = name.."/"..fileName
        if isfile(filepath) then
            local file = loadstring(readfile(filepath))
            local version = file and file() and file().getgenv().version or nil
            if version == "1.0" then
                print(fileName .. " is already up-to-date.")
            else
                local Response = syn.request({
                    Url = url,
                    Method = "HEAD"
                })
                if Response and Response.Headers and Response.Headers["Last-Modified"] then
                    local lastModified = Response.Headers["Last-Modified"]
                    local fileModified = readfile(filepath, "*all", "*t").modification
                    if lastModified ~= fileModified then
                        local Response = syn.request({
                            Url = url,
                            Method = "GET"
                        })
                        if Response then
                            writefile(filepath, Response.Body)
                            rconsoleprint(fileName .. "\n has been updated.")
                       else
                        rconsoleinfo("error: You already have the files or Script cant find files")
                        rconsoleprint("\nError: Could not download ".. fileName)
                        end
                    else
                        rconsoleprint(fileName .. "\n is already up-to-date.")
                    end
                else
                    rconsoleinfo("\n error: You already have the files or Script cant find files")
                    rconsoleprint("\n Error: Could not download ".. fileName)
                end
            end
        else
            local Response = syn.request({
                Url = url,
                Method = "GET"
            })
            if Response then
                wait(0.2)
                rconsoleinfo("\n Downloading...")
                writefile(filepath, Response.Body)
                rconsoleprint(fileName .. "\n has been downloaded.")
            else
                rconsoleinfo("\n error: You already have the files or Script cant find files")
                rconsoleprint("\n Error: Could not download ".. fileName)
            end
        end            
    end
end
