AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.NextTouchSoundT = 0
ENT.Dead = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Initialize()
	self:SetModel("models/vj_eye/limacue_egg.mdl")
	self:SetMaxHealth(10)
	self:SetHealth(10)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PhysicsCollide(data)
	if CurTime() > self.NextTouchSoundT then
		self.touchsound = CreateSound(self, "physics/flesh/flesh_squishy_impact_hard"..math.random(1,4)..".wav") self.touchsound:SetSoundLevel(60)
		self.touchsound:PlayEx(1,math.random(80,100))
		self.NextTouchSoundT = CurTime() + 2
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnTakeDamage(dmginfo,data)
	self:SpawnBloodParticles(dmginfo)
	self:SpawnBloodDecal(dmginfo)
	self:EmitSound("vj_flesh/alien_flesh1.wav",80,math.random(80,100))
	
	self:SetHealth(self:Health() -dmginfo:GetDamage())
	if self:Health() <= 0 && self.Dead == false then
		self:SetHealth(self:GetMaxHealth())
		self.Dead = true
	
		self:EmitSound("vj_gib/gibbing1.wav",90,math.random(80,100))
		self:EmitSound("vj_gib/gibbing2.wav",90,math.random(80,100))
		self:EmitSound("vj_gib/gibbing3.wav",90,math.random(80,100))

		self:SpawnBloodParticles(dmginfo)
		self:SpawnBloodParticles(dmginfo)
		
		local ent = ents.Create("npc_vj_eye_turtle")
		ent:SetPos(self:GetPos())
		ent:SetAngles(Angle(0,0,0))
		ent:DropToFloor()
		ent:Spawn()
		ent:Activate()
		self:Remove()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SpawnBloodParticles(dmginfo,hitgroup)
	local DamagePos = dmginfo:GetDamagePosition()
	if DamagePos == Vector(0,0,0) then DamagePos = self:GetPos() + self:OBBCenter() end

	local bloodeffect = ents.Create("info_particle_system")
	bloodeffect:SetKeyValue("effect_name", "blood_impact_red_01")
	bloodeffect:SetPos(DamagePos) 
	bloodeffect:Spawn()
	bloodeffect:Activate() 
	bloodeffect:Fire("Start","",0)
	bloodeffect:Fire("Kill","",0.1)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SpawnBloodDecal(dmginfo,hitgroup)
	local force = dmginfo:GetDamageForce()
	local length = math.Clamp(force:Length() *10, 100, 300)
	local paint = tobool(math.random(0, math.Round(length *0.125)) <= 1000)
	if !paint then return end
	local posStart = dmginfo:GetDamagePosition()
	local posEnd = posStart +force:GetNormal() *length
	local tr = util.TraceLine({start = posStart, endpos = posEnd, filter = self})
	if !tr.HitWorld then return end
	util.Decal("VJ_Blood_Red",tr.HitPos +tr.HitNormal,tr.HitPos -tr.HitNormal)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/