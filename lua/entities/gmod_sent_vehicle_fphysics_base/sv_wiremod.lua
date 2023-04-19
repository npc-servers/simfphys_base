
function ENT:createWireIO()
	self.Inputs = WireLib.CreateInputs( self,{"Eject Driver","Eject Passengers","Lock","Engine Start","Engine Stop","Engine Toggle","Steer","Throttle","Gear Up","Gear Down","Set Gear","Clutch","Handbrake","Brake/Reverse"} )
	--self.Inputs = WireLib.CreateSpecialInputs(self, { "blah" }, { "NORMAL" })
	
	self.Outputs = WireLib.CreateSpecialOutputs( self, 
		{ "Active","Health","RPM","Torque","DriverSeat","PassengerSeats","Driver","Gear","Ratio","Lights Enabled","Highbeams Enabled","Foglights Enabled","Sirens Enabled","Turn Signals Enabled","Remaining Fuel" },
		{ "NORMAL","NORMAL","NORMAL","NORMAL","ENTITY","ARRAY","ENTITY","NORMAL","NORMAL","NORMAL","NORMAL","NORMAL","NORMAL","NORMAL","NORMAL" }
	)
end

function ENT:UpdateWireOutputs()
	WireLib.TriggerOutput(self, "Active", self:EngineActive() and 1 or 0 )
	WireLib.TriggerOutput(self, "Health", self:GetCurHealth() )
	
	WireLib.TriggerOutput(self, "Driver", self:GetDriver() )
	WireLib.TriggerOutput(self, "Torque", self.Torque )
	WireLib.TriggerOutput(self, "RPM", self:GetEngineRPM() )
	
	WireLib.TriggerOutput(self, "Gear", self:GetGear() )
	WireLib.TriggerOutput(self, "Ratio",self:GetGear() == 2 and 0 or (self.GearRatio or 0) )
	
	WireLib.TriggerOutput(self, "Lights Enabled", self:GetLightsEnabled() and 1 or 0 )
	WireLib.TriggerOutput(self, "Highbeams Enabled", self:GetLampsEnabled() and 1 or 0 )
	WireLib.TriggerOutput(self, "Foglights Enabled", self:GetFogLightsEnabled() and 1 or 0 )
	WireLib.TriggerOutput(self, "Sirens Enabled", self:GetEMSEnabled() and 1 or 0 )
	WireLib.TriggerOutput(self, "Turn Signals Enabled", self:GetTSEnabled())
	WireLib.TriggerOutput(self, "Remaining Fuel", self:GetFuel())
end

function ENT:TriggerInput( name, value )
	if name == "Engine Start" then
		if value >= 1 then
			self:SetActive( true )
			self:StartEngine()
		end
	end
	
	if name == "Engine Stop" then
		if value >= 1 then
			self:SetActive( false )
			self:StopEngine()
		end
	end
	
	if name == "Engine Toggle" then
		if value >= 1 then
			if self:GetActive() then
				if not self:EngineActive() then
					self:StartEngine()
				else
					self:StopEngine()
					self:SetActive( false )
				end
			else
				self:SetActive( true )
				self:StartEngine()
			end
		end
	end
	
	if name == "Lock" then
		if value >= 1 then
			self:Lock()
		else
			self:UnLock()
		end
	end
	
	if name == "Eject Driver" then
		local Driver = self:GetDriver()
		if IsValid( Driver ) then
			Driver:ExitVehicle()
		end
	end
	
	if name == "Eject Passengers" then
		if istable( self.pSeat ) then
			for i = 1, table.Count( self.pSeat ) do
				if IsValid( self.pSeat[i] ) then
					
					local Driver = self.pSeat[i]:GetDriver()
					
					if IsValid( Driver ) then
						Driver:ExitVehicle()
					end
				end
			end
		end
	end
	
	if name == "Steer" then
		self:SteerVehicle( math.Clamp( value, -1 , 1) * self.VehicleData["steerangle"] )
		for i = 1, table.Count(self.Wheels) do
			local Wheel = self.Wheels[i]
			if IsValid( Wheel ) then
				Wheel:PhysWake()
			end
		end
	end
	
	if name == "Throttle" then
		self.PressedKeys["joystick_throttle"] = math.Clamp( value, 0, 1 )
	end
	
	if name == "Brake/Reverse" then
		self.PressedKeys["joystick_brake"] = math.Clamp( value, 0, 1 )
	end

	if name == "Gear Up" then
		if value >= 1 then
			self.CurrentGear = math.Clamp(self.CurrentGear + 1,1,table.Count( self.Gears ) )
			self:SetGear( self.CurrentGear )
		end
	end
	
	if name == "Gear Down" then
		if value >= 1 then
			self.CurrentGear = math.Clamp(self.CurrentGear - 1,1,table.Count( self.Gears ) )
			self:SetGear( self.CurrentGear )
		end
	end
	
	if name == "Set Gear" then
		self:ForceGear( math.Round( value, 0 ) )
	end
	
	if name == "Clutch" then
		self.PressedKeys["joystick_clutch"] = math.Clamp( value, 0, 1 )
	end
	
	if name == "Handbrake" then
		self.PressedKeys["joystick_handbrake"] = (value > 0) and 1 or 0
	end
end