util.AddNetworkString( "simfphys_mousesteer" )

net.Receive( "simfphys_mousesteer", function( length, ply )
	if not ply:IsDrivingSimfphys() then return end

	local vehicle = net.ReadEntity()
	local Steer = net.ReadFloat()
	
	if not IsValid( vehicle ) or ply:GetSimfphys() ~= vehicle:GetParent() then return end
	
	vehicle.ms_Steer = Steer
end)
