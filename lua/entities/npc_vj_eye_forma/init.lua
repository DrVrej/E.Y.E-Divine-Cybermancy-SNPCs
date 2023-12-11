AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_eye/forma.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_eye_forma_h")
ENT.HullType = HULL_MEDIUM
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_METASTREUMONIC"}
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 45 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.6 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = GetConVarNumber("vj_eye_forma_d")
ENT.MeleeAttackBleedEnemy = true -- Should the player bleed when attacked by melee
ENT.MeleeAttackBleedEnemyChance = 1 -- How chance there is that the play will bleed? | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 1 -- How much damage will the enemy get on every rep?
ENT.MeleeAttackBleedEnemyTime = 1 -- How much time until the next rep?
ENT.MeleeAttackBleedEnemyReps = 4 -- How many reps?

ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.AnimTbl_LeapAttack = {ACT_RANGE_ATTACK1} -- Melee Attack Animations
ENT.LeapDistance = 400 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 200 -- How close does it have to be until it uses melee?
ENT.TimeUntilLeapAttackDamage = 0.65 -- How much time until it runs the leap damage code?
ENT.NextLeapAttackTime = 3 -- How much time until it can use a leap attack?
ENT.LeapAttackExtraTimers = {0.8, 1} -- Extra leap attack timers | it will run the damage code after the given amount of seconds
ENT.NextAnyAttackTime_Leap = 0.8 -- How much time until it can use any attack again? | Counted in Seconds
ENT.TimeUntilLeapAttackVelocity = 0.6 -- How much time until it runs the velocity code?
ENT.LeapAttackVelocityForward = 250 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 220 -- How much upward force should it apply?
ENT.LeapAttackDamage = GetConVarNumber("vj_eye_forma_d_leap")
ENT.LeapAttackDamageDistance = 150 -- How far does the damage go?

ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.6 -- Next foot step sound when it is walking
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.AnimTbl_Flinch = {ACT_BIG_FLINCH} -- If it uses normal based animation, use this
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"formaeye/foot1.wav","formaeye/foot2.wav","formaeye/foot3.wav","formaeye/foot4.wav"}
//ENT.SoundTbl_Breath = {"formaeye/breathe_loop1.wav"}
ENT.SoundTbl_Idle = {"formaeye/idle1.wav","formaeye/idle2.wav","formaeye/idle3.wav","formaeye/breathe_loop1.wav"}
ENT.SoundTbl_Alert = {"formaeye/alert1.wav","formaeye/alert2.wav"}
ENT.SoundTbl_MeleeAttack = {"formaeye/claw_strike1.wav","formaeye/claw_strike2.wav","formaeye/claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"formaeye/claw_miss1.wav"}
ENT.SoundTbl_LeapAttackJump = {"formaeye/leap1.wav"}
ENT.SoundTbl_LeapAttackDamage = {"formaeye/claw_strike1.wav","formaeye/claw_strike2.wav","formaeye/claw_strike3.wav"}
ENT.SoundTbl_Pain = {"formaeye/pain1.wav","formaeye/pain2.wav"}
ENT.SoundTbl_Death = {"formaeye/die1.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(25, 25, 70), Vector(-25, -25, 0))
	self:SetSkin(math.random(0,1))
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/