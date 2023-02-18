local QBCore = exports['qb-core']:GetCoreObject()
local oxmenu = exports.ox_menu

local function createSkillMenu()
    local menu = oxmenu.CreateMenu('skills', 'Skills')
    menu.setSubtitle('Select a skill to view its level and XP.')

    for k, v in pairs(Config.Skills) do
        local xp = v['Current']
        local level
        if xp <= 100 then
            level = 'Level 0 (Unskilled)'
        elseif xp <= 200 then
            level = 'Level 1 (Beginner)'
        elseif xp <= 400 then
            level = 'Level 2 (Amateur)'
        elseif xp <= 800 then
            level = 'Level 3 (Intermediate)'
        elseif xp <= 1600 then
            level = 'Level 4 (Competent)'
        elseif xp <= 3200 then
            level = 'Level 5 (Skilled)'
        elseif xp <= 6400 then
            level = 'Level 6 (Adept)'
        elseif xp <= 12800 then
            level = 'Level 7 (Master)'
        else
            level = 'Level 8 (Proficient)'
        end

        local item = oxmenu.CreateItem(k, level .. '\nTotal XP: ' .. xp)
        item:setRightBadge(v.icon)
        item:setData('skill', v)
        item:setCallback(function(menu, item)
            local skill = item:getData('skill')
            -- Do something with the selected skill
            -- For example: Trigger an event to open a more detailed menu for that skill
            TriggerEvent('mz-skills:client:SkillSelected', skill)
        end)

        menu:addItem(item)
    end

    menu:open()
end

RegisterCommand(Config.Skillmenu, function()
    if Config.TypeCommand then
        createSkillMenu()
    else
        Wait(10)
    end
end)

RegisterNetEvent("mz-skills:client:CheckSkills")
AddEventHandler("mz-skills:client:CheckSkills", function()
    createSkillMenu()
end)
