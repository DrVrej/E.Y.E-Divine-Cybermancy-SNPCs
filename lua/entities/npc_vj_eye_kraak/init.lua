AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2024 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_eye/kraak.mdl" -- Model(s) to spawn with | Picks a random one if it's a table
ENT.StartHealth = 600
ENT.HullType = HULL_MEDIUM
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_METASTREUMONIC"}
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.HasMeleeAttack = true -- Can this NPC melee attack?
ENT.AnimTbl_MeleeAttack = ACT_MELEE_ATTACK1
ENT.TimeUntilMeleeAttackDamage = false
ENT.MeleeAttackDistance = 95 -- How close an enemy has to be to trigger a melee attack | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.MeleeAttackDamageDistance = 100 -- How far does the damage go | false = Let the base auto calculate on initialize based on the NPC's collision bounds

ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_eye/kraak/tank_walk01.wav","vj_eye/kraak/tank_walk02.wav","vj_eye/kraak/tank_walk03.wav","vj_eye/kraak/tank_walk04.wav","vj_eye/kraak/tank_walk05.wav","vj_eye/kraak/tank_walk06.wav"} //"physics/plaster/ceiling_tile_step4.wav"
ENT.SoundTbl_Idle = {"vj_eye/kraak/kranagull_idle_1.wav","vj_eye/kraak/kranagull_idle_2.wav"}
ENT.SoundTbl_Alert = {"vj_eye/kraak/kranagull_scream_3.wav"}
ENT.SoundTbl_MeleeAttack = {"vj_eye/kraak/kranagull_scream_5.wav","vj_eye/kraak/kranagull_scream_9.wav","vj_eye/kraak/kranagull_scream_10.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_impact_metal/metalhit1.wav","vj_impact_metal/metalhit2.wav","vj_impact_metal/metalhit3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_eye/swipe01.wav","vj_eye/swipe02.wav","vj_eye/swipe03.wav"}
ENT.SoundTbl_Pain = {"vj_eye/kraak/kranagull_scream_6.wav"}
ENT.SoundTbl_Death = {"vj_eye/kraak/kranagull_scream_7.wav","vj_eye/kraak/kranagull_scream_8.wav"}

local sdAlertRegular = "vj_eye/kraak/kranagull_scream_4.wav"
local sdAlertAngry = "vj_eye/kraak/kranagull_scream_3.wav"
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(30, 30, 150), Vector(-30, -30, 0))
	self:SetStepHeight(90)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local getEventName = util.GetAnimEventNameByID
--
function ENT:CustomOnHandleAnimEvent(ev, evTime, evCycle, evType, evOptions)
	local eventName = getEventName(ev)
	if eventName == "AE_KRAAK_ATTACK_LEFT" or eventName == "AE_KRAAK_ATTACK_RIGHT" then
		self:MeleeAttackCode()
	elseif ev == 2050 or ev == 2051 then -- Predefined by the engine, so IDs are always the same
		self:FootStepSoundCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnFootStepSound(moveType, sdFile)
	util.ScreenShake(self:GetPos(), 10, 100, 0.4, 500)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert()
	if self.VJ_IsBeingControlled == true then return end
	if math.random(1, 2) == 1 then
		self.SoundTbl_Alert = sdAlertAngry
		self:VJ_ACT_PLAYACTIVITY(ACT_ARM, true, false, true)
	else
		self.SoundTbl_Alert = sdAlertRegular
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_BeforeChecks()
	local curSeq = self:GetSequenceName(self:GetSequence())
	if curSeq == "Melee" or curSeq == "Melee2" then -- Smashes
		self.MeleeAttackDamage = 75
		self.HasMeleeAttackKnockBack = false
	else -- Slashes | "Melee3", "Melee4"
		self.MeleeAttackDamage = 60
		self.HasMeleeAttackKnockBack = true
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MeleeAttackKnockbackVelocity(hitEnt)
	return self:GetForward()*math.random(200, 230) + self:GetUp()*math.random(300, 330)
end