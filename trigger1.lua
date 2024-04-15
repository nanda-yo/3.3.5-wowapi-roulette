function(event,text,playerName)
    if (event == "CHAT_MSG_RAID_BOSS_EMOTE" and playerName == UnitName("Player")) then
        if text ~= nil then
            i,j = string.find(text,"spell:%d+")
            if i ~= nil and j~= nil then
                text=string.sub(text,i+6,j)
                
                
                local name,_,icon = GetSpellInfo(text)
                if name ~= nil or icon ~= nil then
                    aura_env.name = name
                    aura_env.icon = icon
                end
                
                
                --fallback mechanism to obtain disallowed spells
                --in case something goes wrong
                --also i had so much fun writing it i cant just throw it off :O
            else
                for i=1, #spellRouletteWASkillTable do
                    if string.find(text,spellRouletteWASkillTable[i][1],1,true) then
                        spellRouletteWAIDNum = i 
                        aura_env.name = spellRouletteWASkillTable[i][1]
                        aura_env.icon = spellRouletteWASkillTable[i][2]
                    end
                end
            end
        end
    end
    
    
    
    
    
    
    return true
end

