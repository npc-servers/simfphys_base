if SERVER then
	AddCSLuaFile("simfphys/client/fonts.lua")
	AddCSLuaFile("simfphys/client/tab.lua")
	AddCSLuaFile("simfphys/client/hud.lua")
	AddCSLuaFile("simfphys/client/lighting.lua")
	AddCSLuaFile("simfphys/client/damage.lua")
	AddCSLuaFile("simfphys/client/poseparameter.lua")
	
	AddCSLuaFile("simfphys/anim.lua")
	AddCSLuaFile("simfphys/base_functions.lua")
	AddCSLuaFile("simfphys/base_lights.lua")
	AddCSLuaFile("simfphys/base_vehicles.lua")
	AddCSLuaFile("simfphys/view.lua")
	
	include("simfphys/base_functions.lua")
	include("simfphys/server/spawner.lua")
	include("simfphys/server/mousesteer.lua")
	include("simfphys/server/poseparameter.lua")
	include("simfphys/server/joystick.lua")
end
	
if CLIENT then
	include("simfphys/base_functions.lua")
	include("simfphys/client/fonts.lua")
	include("simfphys/client/tab.lua")
	include("simfphys/client/hud.lua")
	include("simfphys/client/lighting.lua")
	include("simfphys/client/damage.lua")
	include("simfphys/client/poseparameter.lua")
end

include("simfphys/anim.lua")
include("simfphys/base_lights.lua")
include("simfphys/base_vehicles.lua")
include("simfphys/view.lua")


local lvsCars = {}

hook.Add( "PreRegisterSENT", "!!!!!!lvs_register_simfphys_vehicles", function( ent, class )
	if class ~= "gmod_sent_vehicle_fphysics_base" then return end

	for name, data in pairs( list.Get( "simfphys_vehicles" ) ) do
		if not istable( data.Members ) then continue end

		local ENT = {}

		ENT.Base = "gmod_sent_vehicle_fphysics_base"

		ENT.MDL = data.Model

		ENT.PrintName = data.Name
		ENT.Author = data.Author
		ENT.Category = "[LVS] - Cars"

		ENT.Spawnable		= data.Spawnable ~= false
		ENT.AdminSpawnable = data.AdminSpawnable == true

		lvsCars[ name ] = true

		scripted_ents.Register( ENT, name )
	end
end )

hook.Add( "OnEntityCreated", "!!!!lvs_just_in_time_table_merge", function( ent )
	if not IsValid( ent ) then return end

	local class = ent:GetClass()

	if not lvsCars[ class ] then return end

	local vlist = list.Get( "simfphys_vehicles" )[ class ]

	local data = vlist.Members

	ent.MaxHealth = data.MaxHealth or 500

	if SERVER then
		local Z = ( vlist.SpawnOffset or Vector(0,0,0) ).z

		ent:SetPos( ent:GetPos() + Vector(0,0,50 + Z) )

		ent:SetAngles( ent:GetAngles() + Angle(0,(vlist.SpawnAngleOffset or 0),0) )

		ent:InitFromList( data )
	end
end )