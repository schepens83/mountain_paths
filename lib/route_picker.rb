# Chooses the optimal route on the map, from left to right.
class RoutePicker	

	def initialize(map, init_loc)
		@map = map
		@route = Hash.new
		@path = Array.new
		@init_loc = init_loc
	end

	# create the route from left to right. coordinates in [y, x] format. map starts left top.
	def calculate_route
		cl = @init_loc
		@path << cl

		while not at_right_side?(cl)
			cl = next_step(cl)
			@path << cl
		end 

		return @path
	end


	private

	# returns right top coordinates
	def right_top(cl)
		[ cl[0]-1, cl[1]+1 ]
	end

	# returns right mid coordinates
	def right_mid(cl)
		[ cl[0], cl[1]+1 ] 
	end

	# returns right bottom coordinates
	def right_bot(cl)
		[ cl[0]+1, cl[1]+1 ]
	end	

	# return the coordinates of the optimal next step 
	def next_step(cl)
		# its possible to move one coord higher in y direction, otherwise give a very large number that will never be chosen
		cl[0] > 1 ? drt = delta_right_top(cl) : drt = [:rt, 99999999999]
		# its possible to move one coord lower in y direction, otherwise give a very large number that will never be chosen
		cl[0] < @map.nr_rows ? drb = delta_right_bot(cl) : drb = [:rb, 99999999999]

		# choose the next step based on the lowest absolute delta
		next_step = [ drt, delta_right_mid(cl), drb ].min_by { |i| i[1].abs }

		case next_step[0]
		when :rt
			return right_top(cl)
		when :rm
			return right_mid(cl)
		when :rb
			return right_bot(cl)
		end 
	end

	# calculates the delta between current location (cl) and it's right top location
	def delta_right_top(cl)
		# cl is the current location
		[:rt, @map.grid[cl] - @map.grid[ right_top(cl) ]]
	end

	# calculates the delta between current location (cl) and it's right mid location
	def delta_right_mid(cl)
		# cl is the current location
		[:rm, @map.grid[cl] - @map.grid[ right_mid(cl) ]]
	end

	# calculates the delta between current location (cl) and it's right bottom location
	def delta_right_bot(cl)
		# cl is the current location
		[:rb, @map.grid[cl] - @map.grid[ right_bot(cl) ]]
	end	

	# returns true if the rightermost column has been reached. false otherwise.
	def at_right_side?(cl)
		cl[1] == @map.nr_columns
	end

end