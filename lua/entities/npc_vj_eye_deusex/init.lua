AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_eye/deusex.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_eye_deusex_h")
ENT.HullType = HULL_LARGE
ENT.VJ_IsHugeMonster = true -- Is this a huge monster?
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_METASTREUMONIC"}
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDamageType = bit.bor(DMG_CRUSH, DMG_ALWAYSGIB) -- Type of Damage
ENT.MeleeAttackDistance = 105 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 250 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.62 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = GetConVarNumber("vj_eye_deusex_d")
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 580 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 620 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackKnockBack_Up1 = 580 -- How far it will push you up | First in math.random
ENT.MeleeAttackKnockBack_Up2 = 610 -- How far it will push you up | Second in math.random

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {ACT_IDLE_ANGRY} -- Range Attack Animations
ENT.RangeAttackEntityToSpawn = "obj_eye_deusex_rocket" -- The entity that is spawned when range attacking
ENT.RangeDistance = 8000 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 500 -- How close does it have to be until it uses melee?
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "missile" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.TimeUntilRangeAttackProjectileRelease = 0.4 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 5 -- How much time until it can use a range attack?
ENT.RangeAttackReps = 7 -- How many times does it run the projectile code?
ENT.Immune_Physics = true -- If set to true, the SNPC won't take damage from props

ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.HasWorldShakeOnMove = true -- Should the world shake when it's moving?
ENT.NextWorldShakeOnRun = 0.6 -- How much time until the world shakes while it's running
ENT.NextWorldShakeOnWalk = 0.6 -- How much time until the world shakes while it's walking
ENT.WorldShakeOnMoveAmplitude = 10 -- How much the screen will shake | From 1 to 16, 1 = really low 16 = really high
ENT.WorldShakeOnMoveRadius = 4000 -- How far the screen shake goes, in world units
ENT.WorldShakeOnMoveDuration = 0.4 -- How long the screen shake will last, in seconds
ENT.WorldShakeOnMoveFrequency = 100 -- Just leave it to 100
ENT.FootStepTimeRun = 0.6 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.6 -- Next foot step sound when it is walking
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"deuseye/deus_footstep_01_mono.wav","deuseye/deus_footstep_02_mono.wav"}
ENT.SoundTbl_Idle = {"deuseye/deus_idle_1.wav","deuseye/deus_idle_2.wav"}
ENT.SoundTbl_Alert = {"deuseye/deus_scream_1.wav","deuseye/deus_scream_2.wav"}
ENT.SoundTbl_MeleeAttack = {"deuseye/deus_scream_3.wav","deuseye/deus_scream_4.wav"}
ENT.SoundTbl_MeleeAttackExtra = {"vj_impact_metal/metalhit1.wav","vj_impact_metal/metalhit2.wav","vj_impact_metal/metalhit3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_eyegeneral/swipe01.wav","vj_eyegeneral/swipe02.wav","vj_eyegeneral/swipe03.wav"}
ENT.SoundTbl_RangeAttack = {"deuseye/deus_walk_01_mono.wav","deuseye/deus_walk_02_mono.wav"}
ENT.SoundTbl_Pain = {"deuseye/deus_scream_5.wav","deuseye/deus_scream_6.wav"}
ENT.SoundTbl_Death = {"deuseye/deus_scream_7.wav","deuseye/deus_scream_8.wav","deuseye/deus_scream_9.wav"}

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

ENT.RangeAttackPitch1 = 100
ENT.RangeAttackPitch2 = 100

-- Custom
ENT.Deusex_NextGunRotate = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(90, 90, 420), Vector(-90, -90, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
	if self.RangeAttacking == true && CurTime() > self.Deusex_NextGunRotate then
		self:RestartGesture(ACT_GESTURE_RANGE_ATTACK1)
		self.Deusex_NextGunRotate = CurTime() + 0.2
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_OverrideProjectilePos(TheProjectile)
	return self:GetAttachment(self:LookupAttachment(self.RangeUseAttachmentForPosID)).Pos +self:GetUp()*-35
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
	return self:CalculateProjectile("Line", self:GetAttachment(self:LookupAttachment(self.RangeUseAttachmentForPosID)).Pos +self:GetUp()*-35, self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter(), 5000)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/