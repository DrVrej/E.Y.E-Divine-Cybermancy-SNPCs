AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2024 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_eye/kraak.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 600
ENT.HullType = HULL_MEDIUM
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_METASTREUMONIC"}
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDistance = 54 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 115 -- How far does the damage go?
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy

ENT.FootStepTimeRun = 0.5 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"kraakeye/tank_walk01.wav","kraakeye/tank_walk02.wav","kraakeye/tank_walk03.wav","kraakeye/tank_walk04.wav","kraakeye/tank_walk05.wav","kraakeye/tank_walk06.wav"} //"physics/plaster/ceiling_tile_step4.wav"
ENT.SoundTbl_Idle = {"kraakeye/kranagull_idle_1.wav","kraakeye/kranagull_idle_2.wav"}
ENT.SoundTbl_Alert = {"kraakeye/kranagull_scream_3.wav"}
ENT.SoundTbl_MeleeAttack = {"kraakeye/kranagull_scream_5.wav","kraakeye/kranagull_scream_9.wav","kraakeye/kranagull_scream_10.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_impact_metal/metalhit1.wav","vj_impact_metal/metalhit2.wav","vj_impact_metal/metalhit3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_eyegeneral/swipe01.wav","vj_eyegeneral/swipe02.wav","vj_eyegeneral/swipe03.wav"}
ENT.SoundTbl_Pain = {"kraakeye/kranagull_scream_6.wav"}
ENT.SoundTbl_Death = {"kraakeye/kranagull_scream_7.wav","kraakeye/kranagull_scream_8.wav"}

local sdAlertRegular = {"kraakeye/kranagull_scream_4.wav"}
local sdAlertAngry = {"kraakeye/kranagull_scream_3.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(30, 30, 150), Vector(-30, -30, 0))
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
function ENT:MeleeAttackKnockbackVelocity(hitEnt)
	return self:GetForward()*math.random(200, 230) + self:GetUp()*math.random(300, 330)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local randAttack = math.random(1, 3)
	if randAttack == 1 then
		self.AnimTbl_MeleeAttack = {"vjseq_melee","vjseq_melee2"}
		self.TimeUntilMeleeAttackDamage = 0.45
		self.MeleeAttackDamage = 75
		self.HasMeleeAttackKnockBack = false
	elseif randAttack == 2 then
		self.AnimTbl_MeleeAttack = {"vjseq_melee3"}
		self.TimeUntilMeleeAttackDamage = 0.55
		self.MeleeAttackDamage = 60
		self.HasMeleeAttackKnockBack = true
	elseif randAttack == 3 then
		self.AnimTbl_MeleeAttack = {"vjseq_melee4"}
		self.TimeUntilMeleeAttackDamage = 0.5
		self.MeleeAttackDamage = 60
		self.HasMeleeAttackKnockBack = true
	end
end