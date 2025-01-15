AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2025 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_eye/troopers.mdl" -- Model(s) to spawn with | Picks a random one if it's a table
ENT.StartHealth = 200
ENT.HullType = HULL_MEDIUM
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_FEDERALISTS"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = VJ.BLOOD_COLOR_OIL

ENT.HasMeleeAttack = true -- Can this NPC melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1, "melee2"}
ENT.TimeUntilMeleeAttackDamage = false
ENT.MeleeAttackDistance = 40 -- How close an enemy has to be to trigger a melee attack | false = Let the base auto calculate on initialize based on the NPC's collision bounds
ENT.MeleeAttackDamageDistance = 100 -- How far does the damage go | false = Let the base auto calculate on initialize based on the NPC's collision bounds

ENT.FootStepTimeRun = 0.3 -- Delay between footstep sounds while it is running | false = Disable while running
ENT.FootStepTimeWalk = 0.5 -- Delay between footstep sounds while it is walking | false = Disable while walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = ACT_FLINCH_PHYSICS -- The regular flinch animations to play
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
ENT.SoundTbl_FootStep = "physics/plaster/ceiling_tile_step4.wav"
ENT.SoundTbl_Idle = {"vj_eye/trooper/pass_temple_activate.wav","vj_eye/trooper/scream.wav"}
//ENT.SoundTbl_CombatIdle = "vj_eye/trooper/alarm.wav" -- Avoid using, its a looping wav file!
ENT.SoundTbl_Alert = "vj_eye/trooper/active.wav"
ENT.SoundTbl_MeleeAttack = {"vj_eye/trooper/attack1.wav","vj_eye/trooper/attack2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"vj_eye/swipe01.wav","vj_eye/swipe02.wav","vj_eye/swipe03.wav"}
ENT.SoundTbl_Pain = {"vj_eye/trooper/pain1.wav","vj_eye/trooper/pain2.wav"}
ENT.SoundTbl_Impact = {"ambient/energy/spark1.wav","ambient/energy/spark2.wav","ambient/energy/spark3.wav","ambient/energy/spark4.wav"}
ENT.SoundTbl_Death = "vj_eye/trooper/die.wav"
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
	self:SetCollisionBounds(Vector(25, 25, 80), Vector(-25, -25, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
local getEventName = util.GetAnimEventNameByID
--
function ENT:OnAnimEvent(ev, evTime, evCycle, evType, evOptions)
	local eventName = getEventName(ev)
	if eventName == "AE_TROOPERS_ATTACK_LEFT" or eventName == "AE_TROOPERS_ATTACK_RIGHT" then
		self:MeleeAttackCode()
	//elseif eventName == "AE_TROOPERS_GALLOP_LEFT" or eventName == "AE_TROOPERS_GALLOP_RIGHT" then -- For some reason only running animation has it...
		//self:FootStepSoundCode()
	end
end