class Route
	attr_accessor :stations

	def initialize (start_stations, end_stations)
		@stations = [start_stations, end_stations]
	end

	def add_station(station)
		stations.insert(-2, station)
	end

	def dellete_station(station)
		[stations.first, stations.last].include?(station)? false : stations.delete(station)
	end

	def stations_list
		stations.each{ |station| puts station }
	end

end
