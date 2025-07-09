local found = filtergc("function", {
    Constants = {
        [2] = "GetLogHistory",
        [6] = "CoreGui",
        [9] = "^(%S*)%.(%S*)",
        [10] = "insert",
        [14] = "Elysian exploit detected"
    }
}, true)

if found then
    for i, v in pairs(getupvalues(found)) do
        if typeof(v) == "function" and not iscclosure(v) then
            hookfunction(v, function(...) -- Cauze its an adonis skid off i just attach the "crash" or "kick" handling function completly fucking this anticheat, You wouldnt even need a handshake emulation if you js want to bypass anti dex anti hook
                return task.wait(9e9)
            end)
        end
    end

    local codeString = [[
        local function xorStrings(str, key)
            local result = ""
            for i = 1, #str do
                local strByte = string.byte(str, i)
                local keyByte = string.byte(key, ((i - 1) % #key) + 1)
                result = result .. string.char(bit32.bxor(strByte, keyByte))
            end
            return result
        end

        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local VRAN = ReplicatedStorage:WaitForChild("VRAN_Event"):WaitForChild("VRAN")

        local decryptionKey
        local EncryptedStuff
        local DecryptedStartup

        VRAN.OnClientEvent:Connect(function(type, payload)
            if type == "key" and not DecryptedStartup then
                EncryptedStuff = payload
            elseif type == "key" and DecryptedStartup then
                print("Cum request Accepted")
                DecryptedStartup = xorStrings(payload, DecryptedStartup)
            end
        end)

        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = { ... }

            if method == "FireServer" and args[1] == "pong" and not checkcaller() then
                decryptionKey = args[2]
                if EncryptedStuff then
                    DecryptedStartup = xorStrings(EncryptedStuff, decryptionKey)
                    self:FireServer("pong", DecryptedStartup)
                    return task.wait(9e9)
                end
            end

            return oldNamecall(self, ...)
        end))

        while task.wait(0.5) do
            print("Sending cum request")
            VRAN:FireServer("pong", DecryptedStartup)
        end
    ]]

    run_on_actor(game:GetService("ReplicatedFirst"):WaitForChild("VM_sys"), codeString)

    local VRAN = game:GetService("ReplicatedFirst").VM_sys:WaitForChild("VRAN")
    task.wait(5)

    for _, conn in ipairs(getconnections(VRAN:GetPropertyChangedSignal("Enabled"))) do
        conn:Disable()
    end

    VRAN.Enabled = false
    print("Fully Bypassed")

else
    game:GetService("Players").LocalPlayer:Kick("COULDNT BRICK")
end
