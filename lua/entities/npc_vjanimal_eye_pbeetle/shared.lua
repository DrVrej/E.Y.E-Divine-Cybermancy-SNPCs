ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= "Pea Beetle"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Look at it wander around."
ENT.Instructions 	= "Click to spawn it."
ENT.Category		= "E.Y.E Divine Cybermancy"

if (CLIENT) then
local Name = "Pea Beetle"
local LangName = "npc_vjanimal_eye_pbeetle"
language.Add(LangName, Name)
killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
language.Add("#"..LangName, Name)
killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end