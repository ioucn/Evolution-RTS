--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function widget:GetInfo()
  return {
    name      = "Shoot Now!",
    desc      = "v0.02 Orders a unit to fire its weapon at the ground below using an action.",
    author    = "CarRepairer",
    date      = "2010-04-18",
    license   = "GNU GPL, v2 or later",
    layer     = 5,
    enabled   = true,
	handler   = true,
  }
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local echo = Spring.Echo

VFS.Include("LuaRules/Configs/customcmds.h.lua")

local unittypes = {
	[UnitDefNames['ecommander'].id] = 1,
}

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function AddAction(cmd, func, data, types)
	return widgetHandler.actionHandler:AddAction(widget, cmd, func, data, types)
end
local function RemoveAction(cmd, types)
	return widgetHandler.actionHandler:RemoveAction(widget, cmd, types)
end


local function EvoCommEMP()
	local selUnits = Spring.GetSelectedUnits()
	for _, unitID in ipairs(selUnits) do
		local udid = Spring.GetUnitDefID(unitID)
		if unittypes[udid] then
			local x,_,z = Spring.GetUnitPosition(unitID)
			local y = Spring.GetGroundHeight(x,z)
			--Spring.GiveOrderToUnit(unitID, CMD.INSERT,{0,CMD.ATTACK,CMD.OPT_INTERNAL,x,y,z},{"alt"})
			Spring.GiveOrderToUnit(unitID, CMD.INSERT,{0,CMD.ATTACK,CMD.OPT_ALT,x,y,z},{"alt"})
			--echo 'attacking'
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------



function widget:CommandsChanged()
	for _, unitID in ipairs(Spring.GetSelectedUnits()) do
		local udid = Spring.GetUnitDefID(unitID)
		if unittypes[udid] then
			table.insert(widgetHandler.customCommands, {
				id      = CMD_SHOOTNOW,
				name	= 'EMP',
				type    = CMDTYPE.ICON,
				tooltip = 'Activate Overseer EMP Defense',
				cursor  = 'Attack',
				action  = 'evocommemp',
				params  = { }, 
				texture = 'LuaUI/Images/commands/emp.png',
		
				pos = {CMD.MOVE_STATE,CMD.FIRE_STATE, }, 
			})
			
		end
	end
end
function widget:CommandNotify(cmdID, cmdParams, cmdOptions)
	if cmdID == CMD_SHOOTNOW then
		EvoCommEMP()
		return true
	end
end
function widget:Initialize()
	AddAction("evocommemp", EvoCommEMP, nil, "t")
	local uikey_hotkey_strs = Spring.GetActionHotKeys("evocommemp")
	if not (uikey_hotkey_strs and uikey_hotkey_strs[1]) then
		Spring.SendCommands({
			"unbindkeyset d",
		})
		Spring.SendCommands("bind d evocommemp")
	end
end

function widget:Shutdown()
	RemoveAction("evocommemp")
	Spring.SendCommands("unbindaction evocommemp")
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------




