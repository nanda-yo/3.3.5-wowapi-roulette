function spellRouletteWASetGlobal()
    if not spellRouletteWASkillTable then do
            setglobal("spellRouletteWASkillTable",{})
    end end
    
    if not spellRouletteWAIDNum then do
            setglobal("spellRouletteWAIDNum",1)
    end end
    if not spellRouletteWAREInit then do
            setglobal("spellRouletteWAREInit",1)
    end end
    
end



local nonSkillItems = {'Auto Attack','Block','Dodge','Dual Wield','Elusiveness','Fatal Wounds','For the Alliance!','Mercenary for Hire!','Parry','Rest','Shadowmeld','Shoot','Throw','Wand','Wildcard Mount','Wisp Spirit','Woodcutting','Battle Horn','Quickness','Resilient Constitution','Mystic Enchantment',"D.I.S.C.O.","Basic Campfire","Enchanting","Disenchant","Cooking","First Aid","Fishing","Leatherworking","Magic Acceleration","Devastating Spells","Devastating Strikes","Heavy Swings","Agile Strikes","Spiritual Acceleration","Empowered Mending","Frostfall","Every Man for Himself","Diplomacy","Perception","The Human Spirit","Find Treasure","Stoneform","Escape Artist","Expansive Mind","Heroic Presence","Gemcutting","Gift of the Naaru","Hardiness","Blood Fury","Command","Cannibalize","Will of the Forsaken","Tame Beast","Underwater Breathing","Endurance","Cultivation","War Stomp","Berserking","Beast Slaying","Da Voodoo Shuffle","Regeneration","Arcane Affinity","Arcane Torrent"}


function locate(nonSkillItemsVar,spellNameVar)
    for i = 1, #nonSkillItemsVar do
        if  nonSkillItemsVar[i] == spellNameVar then return true end
    end
    return false
end




function spellRouletteWAFlushTable()
    local a=0
    if spellRouletteWASkillTable == nil then
        do a=1 end
    else do
            count = #spellRouletteWASkillTable
            for i=1, count do spellRouletteWASkillTable[i]=nil
            end
        end
    end    
end


--a bunch of shit
function spellRouletteWACreateTable()
    
    spellRouletteWASkillTable={}
    
    local counter = 1
    local spellNameOld = "meow"
    local tinsert = table.insert
    while true do
        local spellName, rank, icon = GetSpellInfo(counter,BOOKTYPE_SPELL)
        if not spellName then
        break end
        
        if (spellNameOld == spellName) or (string.find(spellName,"Language")) or (string.find(spellName,"Range ")) or (string.find(spellName,"Mystic Enchantment")) or (string.find(spellName,"(Pv%a)",-5)) or (string.find(spellName,"Stone of Retreat")) or (string.find(spellName,"Soul of the Forgotten -")) or (string.find(spellName,"Primary Stat:")) or (string.find(spellName,"Burning Remnant -")) or (string.find(spellName,"Mastery",-7)) or (string.find(spellName,"Find ")) or (string.find(spellName,"Raid Marker -")) or (string.find(spellName,"Resurrect in ")) or(string.find(spellName,"Resistance",-10)) or (string.find(spellName,"Specialization",-14)) or (string.find(spellName,"Undead",-6)) or (string.find(spellName,"Pet",-3)) or (string.find(spellName,"Track",5)) or (string.find(spellName,"Elemental",-9)) or (string.find(spellName,"Dragonkin",-9)) or (string.find(spellName,"Demon",-5)) or (string.find(spellName,"Lore",-4)) or locate(nonSkillItems,spellName) then 
            
            
            
            if (spellName == "Elemental Mastery" or spellName == "Aura Mastery" or spellName == "Revive Dragonkin" or spellName == "Revive Undead" or spellName == "Revive Pet" or spellName == "Mend Pet" or spellName == "Revive Elemental" or spellName == "Summon Water Elemental" or spellName=="Bind Elemental" or spellName == "Revive Demon" or spellName == "Temporary Enslaved Demon") then
                
                if (spellName == spellNameOld) then
                    counter = counter +1
                else
                    tinsert(spellRouletteWASkillTable,{spellName, icon})
                    counter = counter+1
                    spellNameOld = spellName
                end     
                
            else 
                counter=counter+1
                spellNameOld = spellName
            end
            
        else 
            tinsert(spellRouletteWASkillTable,{spellName, icon})       
            counter = counter + 1
            spellNameOld = spellName
        end
        
    end
end

--sorting table to avoid similarname fuckery in triggers 
function spellRouletteWASortTableDesc()
    local tsort = table.sort
    tsort(spellRouletteWASkillTable, function(a,b) return #a[1]>#b[1] end)
    
end


function spellRouletteWAInit()
    spellRouletteWASetGlobal()
    spellRouletteWAFlushTable()
    spellRouletteWACreateTable()
    spellRouletteWASortTableDesc()
    DEFAULT_CHAT_FRAME:AddMessage("spellRouletteWA: Initialization done, spellbook contains "..#spellRouletteWASkillTable.." potential spells")
end

spellRouletteWAREInit = spellRouletteWAInit

