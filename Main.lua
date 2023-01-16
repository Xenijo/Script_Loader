rconsoleclear() -- This function is used to clear the console.
rconsolename("XenjiosScripts| Press Enter button to continue") -- This function sets the name of the console window to the "XenjiosScripts| Press Enter button to continue"
rconsoleinput() -- this function waits for user to press enter button

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
    makefolder(name) -- this function creates a folder with the name of the value stored in the 'name' variable
end

for i = 1, #files do
    local url = files[i]
    local fileName = url:match("([^/]+)$") -- this function matches the last string after "/" in the url and stores it in fileName
    if fileName then
        local filepath = name.."/"..fileName
        if isfile(filepath) then
            local file = loadstring(readfile(filepath)) -- this function loads the contents of the file at filepath as a string and assigns it to the 'file' variable
            local version = file and file() and file().getgenv().version or nil
            if version == "1.0" then
                print(fileName .. " is already up-to-date.")
            else
                local Response = syn.request({ -- this function sends a request to the specified url 
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
                            writefile(filepath, Response.Body) -- this function writes the contents of the response body to the file at filepath
                            rconsoleprint(fileName .. "\n has been updated.")
                       else
                        rconsoleinfo("error: You already have the files or Script cant find files")
                        rconsoleprint("\nError: Could not download ".. fileName)
                        end
