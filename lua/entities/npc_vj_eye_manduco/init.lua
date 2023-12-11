AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_eye/manduco.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_eye_manduco_h")
ENT.HullType = HULL_WIDE_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_METASTREUMONIC"}
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDistance = 40 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 75 -- How far does the damage go?

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = {ACT_RANGE_ATTACK1} -- Range Attack Animations
ENT.RangeAttackEntityToSpawn = "obj_eye_fireball" -- The entity that is spawned when range attacking
ENT.RangeDistance = 700 -- This is how far away it can shoot
ENT.RangeToMeleeDistance = 200 -- How close does it have to be until it uses melee?
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "fireball" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.TimeUntilRangeAttackProjectileRelease = 0.5 -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 5 -- How much time until it can use a range attack?

ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.Immune_Fire = true -- Immune to fire damage
ENT.FootStepTimeRun = 0.45 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_FLINCH_PHYSICS} -- If it uses normal based animation, use this
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"manducoeye/walk1.wav","manducoeye/walk2.wav","manducoeye/walk3.wav","manducoeye/walk4.wav"}
ENT.SoundTbl_Idle = {"manducoeye/idle.wav","manducoeye/idle2.wav","manducoeye/idle3.wav","manducoeye/gurgle.wav"}
ENT.SoundTbl_Alert = {"manducoeye/alert1.wav","manducoeye/alert2.wav"}
ENT.SoundTbl_MeleeAttack = {"manducoeye/leap1.wav","manducoeye/scream1.wav","manducoeye/breathe.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_eyegeneral/swipe01.wav","vj_eyegeneral/swipe02.wav","vj_eyegeneral/swipe03.wav"}
ENT.SoundTbl_RangeAttack = {"vj_fire/fireball_throw.wav"}
ENT.SoundTbl_Pain = {"manducoeye/pain1.wav","manducoeye/pain2.wav"}
ENT.SoundTbl_Death = {"manducoeye/die1.wav","manducoeye/die2.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(TheProjectile)
	return (self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter()-(self:GetAttachment(self:LookupAttachment(self.RangeUseAttachmentForPosID)).Pos)) +self:GetUp()*220 +self:GetForward()*200
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(23, 23, 70), Vector(-23, -23, 0))
	self:SetSkin(math.random(0,2))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	if  math.random(1, 2) == 1 then
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.TimeUntilMeleeAttackDamage = 0.45
		self.MeleeAttackExtraTimers = {}
		self.MeleeAttackDamage = GetConVarNumber("vj_eye_manduco_d_reg")
	else
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2}
		self.TimeUntilMeleeAttackDamage = 0.45
		self.MeleeAttackExtraTimers = {0.65}
		self.MeleeAttackDamage = GetConVarNumber("vj_eye_manduco_d_dual")
	end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/