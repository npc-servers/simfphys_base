
local function EntityLookup(CreatedEntities)
	return function(id, default)
		if id == nil then return default end
		if id == 0 then return game.GetWorld() end
		local ent = CreatedEntities[id] or (isnumber(id) and ents.GetByIndex(id))
		if IsValid(ent) then return ent else return default end
	end
end

function ENT:ApplyDupeInfo(ply, ent, info, GetEntByID)
	if not istable( WireLib ) then return end

	WireLib.ApplyDupeInfo(ply, ent, info, GetEntByID)
end

function ENT:PreEntityCopy()
	if not istable( WireLib ) then return end

	duplicator.StoreEntityModifier( self, "WireDupeInfo", WireLib.BuildDupeInfo(self) )
end

function ENT:PostEntityPaste(Player,Ent,CreatedEntities)
	self:SetValues()

	self:SetActive( false )
	self:SetDriver( NULL )
	self:SetLightsEnabled( false )
	self:SetLampsEnabled( false )
	self:SetFogLightsEnabled( false )

	self:SetDriverSeat( NULL )
	self:SetFlyWheelRPM( 0 )
	self:SetThrottle( 0 )

	-- allow rebuild of passenger seats
	Ent.pPodKeyIndex = nil
	Ent.pSeats = nil

	-- allow rebuild of crosshair trace filter
	Ent.CrosshairFilterEnts  = nil

	if not istable( WireLib ) then return end

	if Ent.EntityMods and Ent.EntityMods.WireDupeInfo then
		WireLib.ApplyDupeInfo(Player, Ent, Ent.EntityMods.WireDupeInfo, EntityLookup(CreatedEntities))
	end
end
