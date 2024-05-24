AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2024 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_eye/manduco.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 160
ENT.HullType = HULL_WIDE_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_METASTREUMONIC"}
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.TimeUntilMeleeAttackDamage = 0.45
ENT.MeleeAttackDistance = 40 -- How close an enemy has to be to trigger a melee attack | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.MeleeAttackDamageDistance = 75 -- How far does the damage go | false = Let the base auto calculate on initialize based on the NPC's collision bounds

ENT.HasRangeAttack = true -- Should the SNPC have a range attack?
ENT.AnimTbl_RangeAttack = ACT_RANGE_ATTACK1 -- Range Attack Animations
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
ENT.AnimTbl_Flinch = ACT_FLINCH_PHYSICS -- If it uses normal based animation, use this
ENT.HitGroupFlinching_Values = {
	{HitGroup = {HITGROUP_HEAD}, Animation = {"vjges_gesture_flinch_head"}},
	{HitGroup = {HITGROUP_CHEST}, Animation = {"vjges_gesture_flinch_chest"}},
	{HitGroup = {HITGROUP_STOMACH}, Animation = {"vjges_gesture_flinch_stomach"}},
	{HitGroup = {HITGROUP_LEFTARM}, Animation = {"vjges_gesture_flinch_leftArm"}},
	{HitGroup = {HITGROUP_RIGHTARM}, Animation = {"vjges_gesture_flinch_righttArm"}}, -- Note: Manduco has a typo for this anim!
	{HitGroup = {HITGROUP_LEFTLEG}, Animation = {"vjges_gesture_flinch_leftleg"}},
	{HitGroup = {HITGROUP_RIGHTLEG}, Animation = {"vjges_gesture_flinch_rightleg"}}
}
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"vj_eye/manduco/walk1.wav","vj_eye/manduco/walk2.wav","vj_eye/manduco/walk3.wav","vj_eye/manduco/walk4.wav"}
ENT.SoundTbl_Idle = {"vj_eye/manduco/idle.wav","vj_eye/manduco/idle2.wav","vj_eye/manduco/idle3.wav","vj_eye/manduco/gurgle.wav"}
ENT.SoundTbl_Alert = {"vj_eye/manduco/alert1.wav","vj_eye/manduco/alert2.wav"}
ENT.SoundTbl_MeleeAttack = {"vj_eye/manduco/leap1.wav","vj_eye/manduco/scream1.wav","vj_eye/manduco/breathe.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_eye/swipe01.wav","vj_eye/swipe02.wav","vj_eye/swipe03.wav"}
ENT.SoundTbl_RangeAttack = {"vj_fire/fireball_throw.wav"}
ENT.SoundTbl_Pain = {"vj_eye/manduco/pain1.wav","vj_eye/manduco/pain2.wav"}
ENT.SoundTbl_Death = {"vj_eye/manduco/die1.wav","vj_eye/manduco/die2.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackCode_GetShootPos(projectile)
	local projPos = projectile:GetPos()
	return self:CalculateProjectile("Curve", projPos, self:GetAimPosition(self:GetEnemy(), projPos, 1, 700), 700)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(18, 18, 65), Vector(-18, -18, 0))
	self:SetSkin(math.random(0, 2))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:MultipleMeleeAttacks()
	if  math.random(1, 2) == 1 then
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
		self.MeleeAttackExtraTimers = {}
		self.MeleeAttackDamage = 25
	else
		self.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK2}
		self.MeleeAttackExtraTimers = {0.65}
		self.MeleeAttackDamage = 16
	end
end