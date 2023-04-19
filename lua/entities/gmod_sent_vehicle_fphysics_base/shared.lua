
ENT.Base = "lvs_base"

ENT.PrintName = "Comedy Effect"
ENT.Author = "Blu-x92"

ENT.IsSimfphyscar = true
ENT.lvsComedyEffect = true

function ENT:SetupDataTables()
	self:CreateBaseDT()

	self:AddDT( "Float", "SteerSpeed",				{ KeyName = "steerspeed",			Edit = { type = "Float",		order = 1,min = 1, max = 16,		category = "Steering"} } )
	self:AddDT( "Float", "FastSteerConeFadeSpeed",	{ KeyName = "faststeerconefadespeed",	Edit = { type = "Float",		order = 2,min = 1, max = 5000,		category = "Steering"} } )
	self:AddDT( "Float", "FastSteerAngle",			{ KeyName = "faststeerangle",			Edit = { type = "Float",		order = 3,min = 0, max = 1,		category = "Steering"} } )

	self:AddDT( "Float", "FrontSuspensionHeight",		{ KeyName = "frontsuspensionheight",	Edit = { type = "Float",		order = 4,min = -1, max = 1,		category = "Suspension" } } )
	self:AddDT( "Float", "RearSuspensionHeight",		{ KeyName = "rearsuspensionheight",		Edit = { type = "Float",		order = 5,min = -1, max = 1,		category = "Suspension" } } )

	self:AddDT( "Int", "EngineSoundPreset",			{ KeyName = "enginesoundpreset",		Edit = { type = "Int",			order = 6,min = -1, max = 14,		category = "Engine"} } )
	self:AddDT( "Int", "IdleRPM", 					{ KeyName = "idlerpm",				Edit = { type = "Int",			order = 7,min = 1, max = 25000,	category = "Engine"} } )
	self:AddDT( "Int", "LimitRPM", 					{ KeyName = "limitrpm",				Edit = { type = "Int",			order = 8,min = 4, max = 25000,	category = "Engine"} } )
	self:AddDT( "Int", "PowerBandStart", 			{ KeyName = "powerbandstart",			Edit = { type = "Int",			order = 9,min = 2, max = 25000,	category = "Engine"} } )
	self:AddDT( "Int", "PowerBandEnd", 				{ KeyName = "powerbandend",			Edit = { type = "Int",			order = 10,min = 3, max = 25000,	category = "Engine"} } )
	self:AddDT( "Float", "MaxTorque",				{ KeyName = "maxtorque",			Edit = { type = "Float",		order = 11,min = 20, max = 1000,	category = "Engine"} } )
	self:AddDT( "Bool", "Revlimiter",				{ KeyName = "revlimiter",				Edit = { type = "Boolean",		order = 12,					category = "Engine"} } )
	self:AddDT( "Bool", "TurboCharged",				{ KeyName = "turbocharged",			Edit = { type = "Boolean",		order = 13,					category = "Engine"} } )
	self:AddDT( "Bool", "SuperCharged",				{ KeyName = "supercharged",			Edit = { type = "Boolean",		order = 14,					category = "Engine"} } )
	self:AddDT( "Bool", "BackFire",				{ KeyName = "backfire",				Edit = { type = "Boolean",		order = 15,					category = "Engine"} } )
	self:AddDT( "Bool", "DoNotStall",				{ KeyName = "donotstall",				Edit = { type = "Boolean",		order = 16,					category = "Engine"} } )

	self:AddDT( "Float", "DifferentialGear",			{ KeyName = "differentialgear",			Edit = { type = "Float",		order = 17,min = 0.2, max = 6,		category = "Transmission"} } )

	self:AddDT( "Float", "BrakePower",				{ KeyName = "brakepower",			Edit = { type = "Float",		order = 18,min = 0.1, max = 500,	category = "Wheels"} } )
	self:AddDT( "Float", "PowerDistribution",			{ KeyName = "powerdistribution",		Edit = { type = "Float",		order = 19,min = -1, max = 1,		category = "Wheels"} } )
	self:AddDT( "Float", "Efficiency",				{ KeyName = "efficiency",				Edit = { type = "Float",		order = 20,min = 0.2, max = 4,		category = "Wheels"} } )
	self:AddDT( "Float", "MaxTraction",				{ KeyName = "maxtraction",			Edit = { type = "Float",		order = 21,min = 5, max = 1000,	category = "Wheels"} } )
	self:AddDT( "Float", "TractionBias",				{ KeyName = "tractionbias",			Edit = { type = "Float",		order = 22,min = -0.99, max = 0.99,	category = "Wheels"} } )
	self:AddDT( "Bool", "BulletProofTires",			{ KeyName = "bulletprooftires",			Edit = { type = "Boolean",		order = 23,					category = "Wheels"} } )
	self:AddDT( "Vector", "TireSmokeColor",			{ KeyName = "tiresmokecolor",			Edit = { type = "VectorColor",	order = 24,					category = "Wheels"} } )

	self:AddDT( "Float", "FlyWheelRPM" )
	self:AddDT( "Float", "Throttle" )
	self:AddDT( "Int", "Gear" )
	self:AddDT( "Int", "Clutch" )
	self:AddDT( "Bool", "IsCruiseModeOn" )
	self:AddDT( "Bool", "IsBraking" )
	self:AddDT( "Bool", "LightsEnabled" )
	self:AddDT( "Bool", "LampsEnabled" )
	self:AddDT( "Bool", "EMSEnabled" )
	self:AddDT( "Bool", "FogLightsEnabled" )
	self:AddDT( "Bool", "HandBrakeEnabled" )

	self:AddDT( "Float", "VehicleSteer" )

	self:AddDT( "String", "Spawn_List")
	self:AddDT( "String", "Lights_List")
	self:AddDT( "String", "Soundoverride")

	self:AddDT( "Vector", "FuelPortPosition" )

	if SERVER then
		self:NetworkVarNotify( "FrontSuspensionHeight", self.OnFrontSuspensionHeightChanged )
		self:NetworkVarNotify( "RearSuspensionHeight", self.OnRearSuspensionHeightChanged )
		self:NetworkVarNotify( "TurboCharged", self.OnTurboCharged )
		self:NetworkVarNotify( "SuperCharged", self.OnSuperCharged )
		self:NetworkVarNotify( "Active", self.OnActiveChanged )
		self:NetworkVarNotify( "Throttle", self.OnThrottleChanged )
	end

	self:AddDataTables()
end

function ENT:IsSimfphyscar()
	return true
end

local VehicleMeta = FindMetaTable("Entity")
local OldIsVehicle = VehicleMeta.IsVehicle
function VehicleMeta:IsVehicle()
	return self.IsSimfphyscar and self:IsSimfphyscar() or OldIsVehicle(self)
end

function ENT:GetVehicleClass()
	return ""
end

function ENT:GetIsVehicleLocked()
	return self:GetlvsLockedStatus()
end

function ENT:SetIsVehicleLocked( lock )
	self:SetlvsLockedStatus( lock )
end

function ENT:AddDataTables()
end

function ENT:GetCurHealth()
	return self:GetHP()
end

function ENT:GetMaxHealth()
	return self:GetMaxHP()
end

function ENT:GetMaxFuel()
	return self:GetNWFloat( "MaxFuel", 60 )
end

function ENT:GetFuel()
	return self:GetNWFloat( "Fuel", self:GetMaxFuel() )
end

function ENT:GetFuelUse()
	return self:GetNWFloat( "FuelUse", 0 )
end

function ENT:GetFuelType()
	return self:GetNWInt( "FuelType", 1 )
end

function ENT:GetFuelPos()
	return self:LocalToWorld( self:GetFuelPortPosition() )
end

function ENT:OnSmoke()
	return self:GetNWBool( "OnSmoke", false )
end

function ENT:OnFire()
	return self:GetNWBool( "OnFire", false )
end

function ENT:GetBackfireSound()
	return self:GetNWString( "backfiresound" )
end

function ENT:SetBackfireSound( the_sound )
	self:SetNWString( "backfiresound", the_sound ) 
end

function ENT:BodyGroupIsValid( bodygroups )
	for index, groups in pairs( bodygroups ) do
		local mygroup = self:GetBodygroup( index )
		for g_index = 1, table.Count( groups ) do
			if mygroup == groups[g_index] then return true end
		end
	end
	return false
end

function ENT:GetSeatAnimation( ply )
	if not IsValid( ply ) or not ply:IsPlayer() then return -1 end

	local Pod = ply:GetVehicle()

	if not IsValid( Pod ) then return -1 end

	if Pod == self:GetDriverSeat() then 

		if isstring( self.SeatAnim ) then
			return ply:LookupSequence( self.SeatAnim )
		else
			if not self.HasCheckedSeat then -- extra check for client
				self.HasCheckedSeat = true
				self.SeatAnim = list.Get( "simfphys_vehicles" )[ self:GetSpawn_List() ].Members.SeatAnim
			end

			return ply:LookupSequence( "drive_jeep" ) 
		end
	end

	if not istable( self.PassengerSeats ) then -- on client self.PassengerSeats is always nil

		if not self.HasCheckedpSeats then
			self.HasCheckedpSeats = true

			self.PassengerSeats = list.Get( "simfphys_vehicles" )[ self:GetSpawn_List() ].Members.PassengerSeats
		end

		return -1
	end

	local pSeatTBL = self.PassengerSeats[ Pod:GetNWInt( "pPodIndex", -1 ) - 1 ]

	if not istable( pSeatTBL ) then return -1 end -- not taking any chances

	local seq = pSeatTBL.anim

	if not isstring( seq ) then return -1 end -- NOT A SINGLE ONE

	return ply:LookupSequence( seq )
end
