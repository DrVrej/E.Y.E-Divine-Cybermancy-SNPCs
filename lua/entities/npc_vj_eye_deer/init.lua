include("entities/npc_vj_eye_forma/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2025 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_eye/deer.mdl" -- Model(s) to spawn with | Picks a random one if it's a table
ENT.StartHealth = 100
ENT.BloodColor = VJ.BLOOD_COLOR_RED
ENT.MeleeAttackBleedEnemy = false -- Should the player bleed when attacked by melee