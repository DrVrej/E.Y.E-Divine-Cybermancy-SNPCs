AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2024 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_eye/bug.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 10
ENT.HullType = HULL_TINY
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Behavior = VJ_BEHAVIOR_PASSIVE_NATURE -- Doesn't attack anything
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.GibOnDeathDamagesTable = {"All"} -- Damages that it gibs from | "UseDefault" = Uses default damage types | "All" = Gib from any damage
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Idle = {"animaleye/bug_idle.wav"}
ENT.SoundTbl_Alert = {"animaleye/bug_fear.wav"}
ENT.SoundTbl_Pain = {"animaleye/bug_die3.wav"}
ENT.SoundTbl_Death = {"animaleye/bug_die.wav", "animaleye/bug_die2.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(12, 12, 13), Vector(-12, -12, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
local colorYellow = VJ.Color2Byte(Color(255, 221, 35))
--
function ENT:SetUpGibesOnDeath(dmginfo, hitgroup)
	if self.HasGibDeathParticles then
		local effectData = EffectData()
		effectData:SetOrigin(self:GetPos() + self:OBBCenter())
		effectData:SetColor(colorYellow)
		effectData:SetScale(40)
		util.Effect("VJ_Blood1", effectData)
		effectData:SetScale(5)
		effectData:SetFlags(3)
		effectData:SetColor(1)
		util.Effect("bloodspray", effectData)
		util.Effect("bloodspray", effectData)
		
		ParticleEffect("antlion_gib_02_blood", self:GetPos(), self:GetAngles())
	end
	
	self:CreateGibEntity("obj_vj_gib", "UseAlien_Big", {Pos = self:LocalToWorld(Vector(-5,0,10)), Vel = Vector(0,math.Rand(-100,100),0)})
	self:CreateGibEntity("obj_vj_gib", "UseAlien_Big", {Pos = self:LocalToWorld(Vector(5,0,10)), Vel = Vector(0,math.Rand(-100,100),0)})
	self:CreateGibEntity("obj_vj_gib", "UseAlien_Big", {Pos = self:LocalToWorld(Vector(10,0,10)), Vel = Vector(0,math.Rand(-100,100),0)})
	return true
end