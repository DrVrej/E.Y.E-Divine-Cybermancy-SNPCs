AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2024 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_eye/forma.mdl" -- Model(s) to spawn with | Picks a random one if it's a table
ENT.StartHealth = 120
ENT.HullType = HULL_MEDIUM
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_METASTREUMONIC"}
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.HasMeleeAttack = true -- Can this NPC melee attack?
ENT.AnimTbl_MeleeAttack = ACT_MELEE_ATTACK1 -- Melee Attack Animations
ENT.MeleeAttackDistance = 45 -- How close an enemy has to be to trigger a melee attack | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.TimeUntilMeleeAttackDamage = false -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 18
ENT.MeleeAttackBleedEnemy = true -- Should the player bleed when attacked by melee
ENT.MeleeAttackBleedEnemyChance = 1 -- How chance there is that the play will bleed? | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 1 -- How much damage will the enemy get on every rep?
ENT.MeleeAttackBleedEnemyTime = 1 -- How much time until the next rep?
ENT.MeleeAttackBleedEnemyReps = 4 -- How many reps?

ENT.HasLeapAttack = true -- Can this NPC leap attack?
ENT.AnimTbl_LeapAttack = ACT_RANGE_ATTACK1 -- Melee Attack Animations
ENT.LeapDistance = 400 -- The max distance that the NPC can leap from
ENT.LeapToMeleeDistance = 200 -- How close does it have to be until it uses melee?
ENT.TimeUntilLeapAttackDamage = 0.65 -- How much time until it runs the leap damage code?
ENT.NextLeapAttackTime = 3 -- How much time until it can use a leap attack?
ENT.LeapAttackExtraTimers = {0.8, 1} -- Extra leap attack timers | it will run the damage code after the given amount of seconds
ENT.NextAnyAttackTime_Leap = 0.8 -- How much time until it can use any attack again? | Counted in Seconds
ENT.TimeUntilLeapAttackVelocity = 0.6 -- How much time until it runs the velocity code?
ENT.LeapAttackDamage = 25
ENT.LeapAttackDamageDistance = 150 -- How far does the damage go?

ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = ACT_BIG_FLINCH -- If it uses normal based animation, use this
ENT.HitGroupFlinching_Values = {
	{HitGroup = {HITGROUP_HEAD}, Animation = {"vjges_gesture_flinch_head"}},
	{HitGroup = {HITGROUP_CHEST}, Animation = {"vjges_gesture_flinch_chest"}},
	{HitGroup = {HITGROUP_STOMACH}, Animation = {"vjges_gesture_flinch_stomach"}},
	{HitGroup = {HITGROUP_LEFTARM}, Animation = {"vjges_gesture_flinch_leftArm"}},
	{HitGroup = {HITGROUP_RIGHTARM}, Animation = {"vjges_gesture_flinch_rightArm"}},
	{HitGroup = {HITGROUP_LEFTLEG}, Animation = {"vjges_gesture_flinch_leftleg"}},
	{HitGroup = {HITGROUP_RIGHTLEG}, Animation = {"vjges_gesture_flinch_rightleg"}}
}
	-- ====== Sound Paths ====== --
ENT.SoundTbl_FootStep = {"vj_eye/forma/foot1.wav","vj_eye/forma/foot2.wav","vj_eye/forma/foot3.wav","vj_eye/forma/foot4.wav"}
//ENT.SoundTbl_Breath = {"vj_eye/forma/breathe_loop1.wav"}
ENT.SoundTbl_Idle = {"vj_eye/forma/idle1.wav","vj_eye/forma/idle2.wav","vj_eye/forma/idle3.wav","vj_eye/forma/breathe_loop1.wav"}
ENT.SoundTbl_Alert = {"vj_eye/forma/alert1.wav","vj_eye/forma/alert2.wav"}
ENT.SoundTbl_MeleeAttack = {"vj_eye/forma/claw_strike1.wav","vj_eye/forma/claw_strike2.wav","vj_eye/forma/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = "vj_eye/forma/claw_miss1.wav"
ENT.SoundTbl_LeapAttackJump = "vj_eye/forma/leap1.wav"
ENT.SoundTbl_LeapAttackDamage = {"vj_eye/forma/claw_strike1.wav","vj_eye/forma/claw_strike2.wav","vj_eye/forma/claw_strike3.wav"}
ENT.SoundTbl_Pain = {"vj_eye/forma/pain1.wav","vj_eye/forma/pain2.wav"}
ENT.SoundTbl_Death = "vj_eye/forma/die1.wav"
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(18, 18, 60), Vector(-18, -18, 0))
	if self:GetModel() == "models/vj_eye/forma.mdl" then
		self:SetSkin(math.random(0, 1))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local getEventName = util.GetAnimEventNameByID
--
function ENT:CustomOnHandleAnimEvent(ev, evTime, evCycle, evType, evOptions)
	local eventName = getEventName(ev)
	if eventName == "AE_FORMA_ATTACK_LEFT" or eventName == "AE_FORMA_ATTACK_RIGHT" then
		self:MeleeAttackCode()
	elseif eventName == "AE_FORMA_GALLOP_LEFT" or eventName == "AE_FORMA_GALLOP_RIGHT" then
		self:FootStepSoundCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:TranslateActivity(act)
	if (act == ACT_IDLE or ACT_GLIDE) && !self:OnGround() then
		if self.AttackType == VJ.ATTACK_TYPE_LEAP then
			return ACT_RANGE_ATTACK2
		elseif !self:IsMoving() then
			return ACT_GLIDE
		end
	end
	return self.BaseClass.TranslateActivity(self, act)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetLeapAttackVelocity()
	local ene = self:GetEnemy()
	return ((ene:GetPos() + ene:OBBCenter()) - (self:GetPos() + self:OBBCenter())):GetNormal() * 400 + self:GetForward() * 250 + self:GetUp() * 220
end