AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2024 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_eye/manduco.mdl" -- Model(s) to spawn with | Picks a random one if it's a table
ENT.StartHealth = 160
ENT.HullType = HULL_WIDE_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_METASTREUMONIC"}
ENT.BloodColor = VJ.BLOOD_COLOR_YELLOW -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.Immune_Fire = true -- Immune to fire damage

ENT.HasMeleeAttack = true -- Can this NPC melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1, ACT_MELEE_ATTACK2}
ENT.TimeUntilMeleeAttackDamage = false
ENT.MeleeAttackDamage = 10
ENT.MeleeAttackDistance = 45 -- How close an enemy has to be to trigger a melee attack | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.MeleeAttackDamageDistance = 65 -- How far does the damage go | false = Let the base auto calculate on initialize based on the NPC's collision bounds

ENT.HasRangeAttack = true -- Can this NPC range attack?
ENT.AnimTbl_RangeAttack = ACT_RANGE_ATTACK1
ENT.RangeAttackEntityToSpawn = "obj_eye_fireball" -- The entity that is spawned when range attacking
ENT.RangeDistance = 700 -- How far can it range attack?
ENT.RangeToMeleeDistance = 200 -- How close does it have to be until it uses melee?
ENT.TimeUntilRangeAttackProjectileRelease = false -- How much time until the projectile code is ran?
ENT.NextRangeAttackTime = 5 -- How much time until it can use a range attack?

ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.DisableFootStepSoundTimer = true -- If set to true, it will disable the time system for the footstep sound code, allowing you to use other ways like model events
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = ACT_FLINCH_PHYSICS -- The regular flinch animations to play
ENT.HitGroupFlinching_Values = {
	{HitGroup = {HITGROUP_HEAD}, Animation = {"vjges_gesture_flinch_head"}},
	{HitGroup = {HITGROUP_CHEST}, Animation = {"vjges_gesture_flinch_chest"}},
	{HitGroup = {HITGROUP_STOMACH}, Animation = {"vjges_gesture_flinch_stomach"}},
	{HitGroup = {HITGROUP_LEFTARM}, Animation = {"vjges_gesture_flinch_leftArm"}},
	{HitGroup = {HITGROUP_RIGHTARM}, Animation = {"vjges_gesture_flinch_righttArm"}}, -- Note: Manduco has a typo for this anim!
	{HitGroup = {HITGROUP_LEFTLEG}, Animation = {"vjges_gesture_flinch_leftleg"}},
	{HitGroup = {HITGROUP_RIGHTLEG}, Animation = {"vjges_gesture_flinch_rightleg"}}
}
	-- ====== Sound Paths ====== --
ENT.SoundTbl_FootStep = {"vj_eye/manduco/walk1.wav","vj_eye/manduco/walk2.wav","vj_eye/manduco/walk3.wav","vj_eye/manduco/walk4.wav"}
ENT.SoundTbl_Idle = {"vj_eye/manduco/idle.wav","vj_eye/manduco/idle2.wav","vj_eye/manduco/idle3.wav","vj_eye/manduco/gurgle.wav"}
ENT.SoundTbl_Alert = {"vj_eye/manduco/alert1.wav","vj_eye/manduco/alert2.wav"}
ENT.SoundTbl_MeleeAttack = {"vj_eye/manduco/leap1.wav","vj_eye/manduco/scream1.wav","vj_eye/manduco/breathe.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_eye/swipe01.wav","vj_eye/swipe02.wav","vj_eye/swipe03.wav"}
ENT.SoundTbl_RangeAttack = "vj_base/ambience/fireball_throw.wav"
ENT.SoundTbl_Pain = {"vj_eye/manduco/pain1.wav","vj_eye/manduco/pain2.wav"}
ENT.SoundTbl_Death = {"vj_eye/manduco/die1.wav","vj_eye/manduco/die2.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
	self:SetCollisionBounds(Vector(18, 18, 65), Vector(-18, -18, 0))
	self:SetSkin(math.random(0, 2))
end
---------------------------------------------------------------------------------------------------------------------------------------------
local getEventName = util.GetAnimEventNameByID
--
function ENT:OnAnimEvent(ev, evTime, evCycle, evType, evOptions)
	local eventName = getEventName(ev)
	if eventName == "AE_MANDUCO_ATTACK_LEFT" or eventName == "AE_MANDUCO_ATTACK_RIGHT" then
		self:MeleeAttackCode()
	elseif eventName == "AE_MANDUCO_FIREBALL" then
		self:RangeAttackCode()
	elseif eventName == "AE_MANDUCO_GALLOP_LEFT" or eventName == "AE_MANDUCO_GALLOP_RIGHT" then
		self:FootStepSoundCode()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackProjSpawnPos(projectile)
	return self:GetAttachment(self:LookupAttachment("fireball")).Pos
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:RangeAttackProjVelocity(projectile)
	local projPos = projectile:GetPos()
	return self:CalculateProjectile("Curve", projPos, self:GetAimPosition(self:GetEnemy(), projPos, 1, 700), 700)
end