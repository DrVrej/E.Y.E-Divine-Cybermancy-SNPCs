/*--------------------------------------------------
	*** Copyright (c) 2012-2024 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "obj_vj_projectile_base"
ENT.PrintName		= "FireBall"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Information		= "Projectile, usually used for NPCs & Weapons"
ENT.Category		= "Projectiles"

if (CLIENT) then
	local Name = "FireBall"
	local LangName = "obj_eye_fireball"
	language.Add(LangName, Name)
	killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
	language.Add("#"..LangName, Name)
	killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if !SERVER then return end

ENT.Model = "models/dav0r/hoverball.mdl" -- The models it should spawn with | Picks a random one from the table
ENT.DoesRadiusDamage = true -- Should it do a blast damage when it hits something?
ENT.RadiusDamageRadius = 110 -- How far the damage go? The farther away it's from its enemy, the less damage it will do | Counted in world units
ENT.RadiusDamage = 25 -- How much damage should it deal? Remember this is a radius damage, therefore it will do less damage the farther away the entity is from its enemy
ENT.RadiusDamageUseRealisticRadius = true -- Should the damage decrease the farther away the enemy is from the position that the projectile hit?
ENT.RadiusDamageType = DMG_BLAST -- Damage type
ENT.RadiusDamageForce = 80 -- Put the force amount it should apply | false = Don't apply any force
ENT.ShakeWorldOnDeath = true -- Should the world shake when the projectile hits something?
ENT.ShakeWorldOnDeathAmplitude = 16 -- How much the screen will shake | From 1 to 16, 1 = really low 16 = really high
ENT.ShakeWorldOnDeathRadius = 800 -- How far the screen shake goes, in world units
ENT.ShakeWorldOnDeathFrequency = 200 -- The frequency
ENT.DecalTbl_DeathDecals = {"Scorch"}
ENT.SoundTbl_Idle = "ambient/fire/fire_small_loop1.wav"
ENT.SoundTbl_OnCollide = "vj_base/ambience/fireball_explode.wav"
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomPhysicsObjectOnInitialize(phys)
	phys:Wake()
	phys:SetMass(2)
	phys:EnableDrag(false)
	phys:SetBuoyancyRatio(0)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetMaterial("models/effect/vol_light001")
	self:SetNoDraw(true)

	//ParticleEffectAttach("smoke_burning_engine_01", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	//ParticleEffectAttach("fire_jet_01_flame", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	ParticleEffectAttach("vj_eye_fireball", PATTACH_ABSORIGIN_FOLLOW, self, 0)

	//local spriteGlow = ents.Create("env_sprite")
	//spriteGlow:SetKeyValue("rendercolor","255 128 0")
	//spriteGlow:SetKeyValue("GlowProxySize","2.0")
	//spriteGlow:SetKeyValue("HDRColorScale","1.0")
	//spriteGlow:SetKeyValue("renderfx","14")
	//spriteGlow:SetKeyValue("rendermode","3")
	//spriteGlow:SetKeyValue("renderamt","255")
	//spriteGlow:SetKeyValue("disablereceiveshadows","0")
	//spriteGlow:SetKeyValue("mindxlevel","0")
	//spriteGlow:SetKeyValue("maxdxlevel","0")
	//spriteGlow:SetKeyValue("framerate","10.0")
	//spriteGlow:SetKeyValue("model","sprites/blueflare1.spr")
	//spriteGlow:SetKeyValue("spawnflags","0")
	//spriteGlow:SetKeyValue("scale","0.75")
	//spriteGlow:SetPos(self:GetPos())
	//spriteGlow:Spawn()
	//spriteGlow:SetParent(self)
	//self:DeleteOnRemove(spriteGlow)

	local dynLight = ents.Create("light_dynamic")
	dynLight:SetKeyValue("brightness", "1")
	dynLight:SetKeyValue("distance", "200")
	dynLight:SetLocalPos(self:GetPos())
	dynLight:SetLocalAngles(self:GetAngles())
	dynLight:Fire("Color", "255 150 0")
	dynLight:SetParent(self)
	dynLight:Spawn()
	dynLight:Activate()
	dynLight:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(dynLight)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeathEffects(data,phys)
	local effectData = EffectData()
	effectData:SetOrigin(data.HitPos)
	//effectData:SetScale(10)
	util.Effect("HelicopterMegaBomb", effectData)
	util.Effect("ThumperDust", effectData)
	util.Effect("Explosion", effectData)
	util.Effect("VJ_Small_Explosion1", effectData)

	local expLight = ents.Create("light_dynamic")
	expLight:SetKeyValue("brightness", "5")
	expLight:SetKeyValue("distance", "300")
	expLight:SetLocalPos(data.HitPos)
	expLight:SetLocalAngles(self:GetAngles())
	expLight:Fire("Color", "255 150 0")
	expLight:SetParent(self)
	expLight:Spawn()
	expLight:Activate()
	expLight:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(expLight)
end