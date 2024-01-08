AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_eye/bug.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = GetConVarNumber("vj_eye_beetle_h")
ENT.HullType = HULL_TINY
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.Behavior = VJ_BEHAVIOR_PASSIVE_NATURE -- Doesn't attack anything
ENT.BloodColor = "Yellow" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.BloodPoolSize = "Small" -- What's the size of the blood pool?
ENT.GibOnDeathDamagesTable = {"All"} -- Damages that it gibs from | "UseDefault" = Uses default damage types | "All" = Gib from any damage
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Idle = {"animaleye/bug_idle.wav"}
ENT.SoundTbl_Alert = {"animaleye/bug_fear.wav"}
ENT.SoundTbl_Pain = {"animaleye/bug_die3.wav"}
ENT.SoundTbl_Death = {"animaleye/bug_die.wav","animaleye/bug_die2.wav"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(12, 12, 13), Vector(-12, -12, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
	if self.HasGibDeathParticles == true then
		local bloodeffect = EffectData()
		bloodeffect:SetOrigin(self:GetPos() +self:OBBCenter())
		bloodeffect:SetColor(VJ_Color2Byte(Color(255,221,35)))
		bloodeffect:SetScale(40)
		util.Effect("VJ_Blood1",bloodeffect)
		
		local bloodspray = EffectData()
		bloodspray:SetOrigin(self:GetPos() +self:OBBCenter())
		bloodspray:SetScale(5)
		bloodspray:SetFlags(3)
		bloodspray:SetColor(1)
		util.Effect("bloodspray",bloodspray)
		util.Effect("bloodspray",bloodspray)
		
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos() +self:OBBCenter())
		effectdata:SetScale(0.4)
		util.Effect("StriderBlood",effectdata)
		util.Effect("StriderBlood",effectdata)
		
		ParticleEffect("antlion_gib_02_blood", self:GetPos(), Angle(0,0,0), nil)
	end
	
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big",{Pos=self:LocalToWorld(Vector(-5,0,10)),Vel=Vector(0,math.Rand(-100,100),0)})
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big",{Pos=self:LocalToWorld(Vector(5,0,10)),Vel=Vector(0,math.Rand(-100,100),0)})
	self:CreateGibEntity("obj_vj_gib","UseAlien_Big",{Pos=self:LocalToWorld(Vector(10,0,10)),Vel=Vector(0,math.Rand(-100,100),0)})
	return true
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/