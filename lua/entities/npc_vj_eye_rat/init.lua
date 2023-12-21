AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2024 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_eye/rat.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 10
ENT.HullType = HULL_TINY
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Behavior = VJ_BEHAVIOR_PASSIVE_NATURE -- Doesn't attack anything
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Idle = {"animaleye/rat_idle1.wav", "animaleye/rat_idle2.wav", "animaleye/rat_idle3.wav", "animaleye/rat_idle4.wav"}
ENT.SoundTbl_Alert = {"animaleye/rat_fear.wav"}
ENT.SoundTbl_Pain = {"animaleye/rat_fear.wav"}
ENT.SoundTbl_Death = {"animaleye/rat_die1.wav", "animaleye/rat_die2.wav","animaleye/rat_die3.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(12, 12, 15), Vector(-12, -12, 0))
end