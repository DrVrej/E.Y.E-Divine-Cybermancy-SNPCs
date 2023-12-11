AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_eye/carnophage.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_eye_carnophage_h")
ENT.HullType = HULL_WIDE_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_METASTREUMONIC"}
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDistance = 40 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.MeleeAttackBleedEnemy = true -- Should the player bleed when attacked by melee
ENT.MeleeAttackBleedEnemyChance = 1 -- How chance there is that the play will bleed? | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 1 -- How much damage will the enemy get on every rep?
ENT.MeleeAttackBleedEnemyTime = 1 -- How much time until the next rep?
ENT.MeleeAttackBleedEnemyReps = 4 -- How many reps?

ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"carnoeye/carnofoot1.mp3","carnoeye/carnofoot2.mp3"}
ENT.SoundTbl_Idle = {"carnoeye/idle1.wav","carnoeye/idle2.wav","carnoeye/idle3.wav"}
ENT.SoundTbl_Alert = {"carnoeye/alert1.wav","carnoeye/alert3.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"carnoeye/leap1.wav","carnoeye/leap2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_eyegeneral/swipe01.wav","vj_eyegeneral/swipe02.wav","vj_eyegeneral/swipe03.wav"}
ENT.SoundTbl_Pain = {"carnoeye/pain1.wav","carnoeye/pain2.wav"}
ENT.SoundTbl_Death = {"carnoeye/scream.wav","carnoeye/die2.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(30, 30, 80), Vector(-30, -30, 0))
	self:SetSkin(math.random(0, 3))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert()
	if self.VJ_IsBeingControlled == true then return end
	if math.random(1, 2) == 1 then
		self.SoundTbl_Alert = {"carnoeye/gurgle_loop1.wav"}
		self:VJ_ACT_PLAYACTIVITY(ACT_ARM, true, false, true)
	else
		self.SoundTbl_Alert = {"carnoeye/alert1.wav","carnoeye/alert3.wav"}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	if math.random(2, 2) == 1 then
		self.AnimTbl_MeleeAttack = {"vjseq_melee2","vjseq_melee3"}
		self.TimeUntilMeleeAttackDamage = 0.4
		self.MeleeAttackExtraTimers = {}
		self.MeleeAttackDamage = GetConVarNumber("vj_eye_carnophage_d_reg")
	else
		self.AnimTbl_MeleeAttack = {"vjseq_melee"}
		self.TimeUntilMeleeAttackDamage = 0.32
		self.MeleeAttackExtraTimers = {0.6}
		self.MeleeAttackDamage = GetConVarNumber("vj_eye_carnophage_d_dual")
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/