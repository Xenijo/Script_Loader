local old 
old = hookfunction(game,HttpGet,function(self,url,...)
    if type(url) == "string" then 
        if string.match(url,"whitelists")then 
        return "Whitelisted"
    end
end 
return old(self,url,...)
end)
print("works ")
        