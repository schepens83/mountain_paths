# Chooses the optimal route on the map, from left to right.
class RoutePicker	

	def initialize(map, init_loc)
		p @map = map
		@init_loc = init_loc
		@route = Hash.new
		pick_route
	end

	def pick_route
		p @map.grid[@init_loc]

		
	end

	def delta_right_top(cl)
		# cl is the current location
		@map[cl] - @map[ [cl[1]-1, cl[0]+1] ]
	end

	def delta_right_mid(cl)
		# cl is the current location
		@map[cl] - @map[ [cl[1], cl[0]+1] ]
	end

	def delta_right_bot(cl)
		# cl is the current location
		@map[cl] - @map[ [cl[1]+1, cl[0]+1] ]
	end	

end