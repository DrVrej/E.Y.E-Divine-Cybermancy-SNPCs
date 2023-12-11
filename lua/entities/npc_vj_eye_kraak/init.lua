AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_eye/kraak.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_eye_kraak_h")
ENT.HullType = HULL_MEDIUM
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_METASTREUMONIC"}
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDistance = 54 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 115 -- How far does the damage go?
ENT.HasMeleeAttackKnockBack = true -- If true, it will cause a knockback to its enemy
ENT.MeleeAttackKnockBack_Forward1 = 200 -- How far it will push you forward | First in math.random
ENT.MeleeAttackKnockBack_Forward2 = 230 -- How far it will push you forward | Second in math.random
ENT.MeleeAttackKnockBack_Up1 = 300 -- How far it will push you up | First in math.random
ENT.MeleeAttackKnockBack_Up2 = 330 -- How far it will push you up | Second in math.random

ENT.FootStepTimeRun = 0.5 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.WorldShakeOnMoveAmplitude = 10 -- How much the screen will shake | From 1 to 16, 1 = really low 16 = really high
ENT.HasWorldShakeOnMove = true -- Should the world shake when it's moving?
ENT.NextWorldShakeOnRun = 0.5 -- How much time until the world shakes while it's running
ENT.NextWorldShakeOnWalk = 0.5 -- How much time until the world shakes while it's walking
ENT.WorldShakeOnMoveRadius = 500 -- How far the screen shake goes, in world units
ENT.WorldShakeOnMoveDuration = 0.4 -- How long the screen shake will last, in seconds
ENT.WorldShakeOnMoveFrequency = 100 -- Just leave it to 100
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

//ENT.FootStepSoundLevel = 90

//ENT.FootStepPitch1 = 50
//ENT.FootStepPitch2 = 60
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(30, 30, 140), Vector(-30, -30, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert()
	if self.VJ_IsBeingControlled == true then return end
	if math.random(1,2) == 1 then
		self.SoundTbl_Alert = {"kraakeye/kranagull_scream_4.wav"}
		self:VJ_ACT_PLAYACTIVITY(ACT_ARM, true, false, true)
	else
		self.SoundTbl_Alert = {"kraakeye/kranagull_scream_3.wav"}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	local randAttack = math.random(1, 3)
	if randAttack == 1 then
		self.AnimTbl_MeleeAttack = {"vjseq_melee","vjseq_melee2"}
		self.TimeUntilMeleeAttackDamage = 0.45
		self.MeleeAttackDamage = GetConVarNumber("vj_eye_kraak_d_stab")
		self.HasMeleeAttackKnockBack = false
	elseif randAttack == 2 then
		self.AnimTbl_MeleeAttack = {"vjseq_melee3"}
		self.TimeUntilMeleeAttackDamage = 0.55
		self.MeleeAttackDamage = GetConVarNumber("vj_eye_kraak_d_push")
		self.HasMeleeAttackKnockBack = true
	elseif randAttack == 3 then
		self.AnimTbl_MeleeAttack = {"vjseq_melee4"}
		self.TimeUntilMeleeAttackDamage = 0.5
		self.MeleeAttackDamage = GetConVarNumber("vj_eye_kraak_d_push")
		self.HasMeleeAttackKnockBack = true
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/