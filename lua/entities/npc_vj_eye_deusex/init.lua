AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2024 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_eye/deusex.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 6000
ENT.HullType = HULL_LARGE
ENT.VJ_IsHugeMonster = true -- Is this a huge monster?
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_METASTREUMONIC"}
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.Immune_Physics = true -- If set to true, the SNPC won't take damage from props

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = ACT_MELEE_ATTACK1 -- Melee Attack Animations
ENT.MeleeAttackDamageType = bit.bor(DMG_CRUSH, DMG_ALWAYSGIB) -- Type of Damage
ENT.MeleeAttackDistance = 105 -- How close an enemy has to be to trigger a melee attack | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.MeleeAttackDamageDistance = 250 -- How far does the damage go | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.TimeUntilMeleeAttackDamage = 0.62 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 75
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.DisableRangeAttackAnimation = true -- if true, it will disable the animation code
ENT.RangeAttackAnimationStopMovement = false -- Should it stop moving when performing a range attack?
ENT.RangeAttackEntityToSpawn = "obj_eye_deusex_rocket" -- The entity that is spawned when range attacking
ENT.RangeDistance = 8000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 500 -- How close does it have to be until it uses melee?
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "missile" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.TimeUntilRangeAttackProjectileRelease = 0.4 -- How much time until the projectile code is ran?
ENT.NextAnyAttackTime_Range = 5 -- How much time until it can use a range attack?
ENT.RangeAttackReps = 7 -- How many times does it run the projectile code?

ENT.NoChaseAfterCertainRange = true -- Should the SNPC not be able to chase when it's between number x and y?
ENT.NoChaseAfterCertainRange_FarDistance = 4000 -- How far until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_CloseDistance = "UseRangeDistance" -- How near until it can chase again? | "UseRangeDistance" = Use the number provided by the range attack instead
ENT.NoChaseAfterCertainRange_Type = "OnlyRange" -- "Regular" = Default behavior | "OnlyRange" = Only does it if it's able to range attack

ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.FootStepTimeRun = 0.6 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.6 -- Next foot step sound when it is walking
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_eye/deusex/deus_footstep_01_mono.wav","vj_eye/deusex/deus_footstep_02_mono.wav"}
ENT.SoundTbl_Idle = {"vj_eye/deusex/deus_idle_1.wav","vj_eye/deusex/deus_idle_2.wav"}
ENT.SoundTbl_Alert = {"vj_eye/deusex/deus_scream_1.wav","vj_eye/deusex/deus_scream_2.wav"}
ENT.SoundTbl_MeleeAttack = {"vj_eye/deusex/deus_scream_3.wav","vj_eye/deusex/deus_scream_4.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_impact_metal/metalhit1.wav","vj_impact_metal/metalhit2.wav","vj_impact_metal/metalhit3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_eye/swipe01.wav","vj_eye/swipe02.wav","vj_eye/swipe03.wav"}
ENT.SoundTbl_RangeAttack = {"vj_eye/deusex/deus_walk_01_mono.wav","vj_eye/deusex/deus_walk_02_mono.wav"}
ENT.SoundTbl_Pain = {"vj_eye/deusex/deus_scream_5.wav","vj_eye/deusex/deus_scream_6.wav"}
ENT.SoundTbl_Death = {"vj_eye/deusex/deus_scream_7.wav","vj_eye/deusex/deus_scream_8.wav","vj_eye/deusex/deus_scream_9.wav"}

ENT.FootStepSoundLevel = 80
ENT.AlertSoundLevel = 95
ENT.IdleSoundLevel = 90
ENT.MeleeAttackSoundLevel = 95
ENT.ExtraMeleeAttackSoundLevel = 80
ENT.RangeAttackSoundLevel = 80
ENT.MeleeAttackMissSoundLevel = 90
ENT.BeforeLeapAttackSoundLevel = 95
ENT.PainSoundLevel = 95
ENT.DeathSoundLevel = 95

ENT.RangeAttackPitch = VJ.SET(100, 100)
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(90, 90, 420), Vector(-90, -90, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
	if act == ACT_IDLE && (self:GetNPCState() == NPC_STATE_ALERT or self:GetNPCState() == NPC_STATE_COMBAT) then
		return ACT_IDLE_ANGRY
	end
	return self.BaseClass.TranslateActivity(self, act)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnFootStepSound(moveType, sdFile)
	util.ScreenShake(self:GetPos(), 10, 100, 0.4, 4000)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MeleeAttackKnockbackVelocity(hitEnt)
	return self:GetForward()*math.random(580, 620) + self:GetUp()*math.random(580, 610)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_OverrideProjectilePos(projectile)
	self:RestartGesture(ACT_GESTURE_RANGE_ATTACK1)
	return self:GetAttachment(self:LookupAttachment(self.RangeUseAttachmentForPosID)).Pos + self:GetForward()*50 + self:GetUp()*-35
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(projectile)
	local projPos = projectile:GetPos()
	return self:CalculateProjectile("Line", projPos, self:GetAimPosition(self:GetEnemy(), projPos, 1, 5000), 5000)
end