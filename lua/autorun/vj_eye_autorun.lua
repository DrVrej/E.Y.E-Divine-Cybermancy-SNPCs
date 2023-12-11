/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2021 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "E.Y.E: Divine Cybermancy SNPCs"
local AddonName = "E.Y.E: Divine Cybermancy"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_eye_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')

	local vCat = "E.Y.E Divine Cybermancy"
	
	VJ.AddNPC("Federal Trooper","npc_vj_eye_trooper",vCat)
	VJ.AddNPC("Kraak","npc_vj_eye_kraak",vCat)
	VJ.AddNPC("Manduco","npc_vj_eye_manduco",vCat)
	VJ.AddNPC("Deus Ex","npc_vj_eye_deusex",vCat)
	VJ.AddNPC("Evil Deer","npc_vj_eye_deer",vCat)
	VJ.AddNPC("Perigrum Forma","npc_vj_eye_forma",vCat)
	VJ.AddNPC("Carnophage","npc_vj_eye_carnophage",vCat)
	VJ.AddNPC("Shelled Tooth Turtle","npc_vj_eye_turtle",vCat)
	VJ.AddNPC("Pea Beetle","npc_vj_eye_pbeetle",vCat)
	VJ.AddNPC("Rat","npc_vj_eye_rat",vCat)
	VJ.AddNPC("Turtle Egg","sent_vj_eye_turtleegg",vCat)
	VJ.AddNPC("Random Animal","sent_vj_eye_randanimal",vCat)

	-- ConVars --
	VJ.AddConVar("vj_eye_carnophage_h",200)
	VJ.AddConVar("vj_eye_carnophage_d_reg",30)
	VJ.AddConVar("vj_eye_carnophage_d_dual",18)

	VJ.AddConVar("vj_eye_deer_h",100)
	VJ.AddConVar("vj_eye_deer_d",18)
	VJ.AddConVar("vj_eye_deer_d_leap",25)

	VJ.AddConVar("vj_eye_deusex_h",6000)
	VJ.AddConVar("vj_eye_deusex_d",70)

	VJ.AddConVar("vj_eye_forma_h",120)
	VJ.AddConVar("vj_eye_forma_d",18)
	VJ.AddConVar("vj_eye_forma_d_leap",25)

	VJ.AddConVar("vj_eye_kraak_h",600)
	VJ.AddConVar("vj_eye_kraak_d_push",60)
	VJ.AddConVar("vj_eye_kraak_d_stab",75)

	VJ.AddConVar("vj_eye_manduco_h",160)
	VJ.AddConVar("vj_eye_manduco_d_reg",25)
	VJ.AddConVar("vj_eye_manduco_d_dual",16)

	VJ.AddConVar("vj_eye_trooper_h",200)
	VJ.AddConVar("vj_eye_trooper_d_double",30)
	VJ.AddConVar("vj_eye_trooper_d_quick",20)

	VJ.AddConVar("vj_eye_beetle_h",10)

	VJ.AddConVar("vj_eye_rat_h",10)

	VJ.AddConVar("vj_eye_turtle_h",10)

-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)
end