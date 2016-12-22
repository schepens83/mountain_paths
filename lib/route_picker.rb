# Chooses the optimal route on the map, from left to right.
class RoutePicker	
	attr_reader :route, :tot_elavation, :init_loc

	def initialize(map, init_loc)
		@map = map
		# @route = Hash.new
		@route = Array.new
		@init_loc = init_loc
		@tot_elavation = 0
	end

	# create the route from left to right. coordinates in [y, x] format. map starts left top.
	def calculate_route
		cl = init_loc
		@route << cl

		while not at_right_side?(cl)
			cl = next_step(cl)
			@route << cl
		end 

		
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
		# choose the next step based on the lowest absolute delta
		next_step = [ delta_right_top(cl), delta_right_mid(cl), delta_right_bot(cl) ].min_by { |i| i[1].abs }

		# increase tot_elavation with the delta between current and next step
		@tot_elavation += next_step[1].abs

		case next_step[0]
		when :rt
			return right_top(cl)
		when :rm
			return right_mid(cl)
		when :rb
			return right_bot(cl)
		end 
	end

	# calculates the delta between current location (cl) and it's right top location. cl is the current location
	def delta_right_top(cl)
		if cl[0] > 1 
			[:rt, @map.grid[cl] - @map.grid[ right_top(cl) ]]
		else
			# give a very large number that will never be chosen
			[:rt, 99999999999]
		end
	end

	# calculates the delta between current location (cl) and it's right mid location
	def delta_right_mid(cl)
		# cl is the current location
		[:rm, @map.grid[cl] - @map.grid[ right_mid(cl) ]]
	end

	# calculates the delta between current location (cl) and it's right bottom location
	def delta_right_bot(cl)
		if cl[0] < @map.nr_rows 
			# give a very large number that will never be chosen
			[:rb, @map.grid[cl] - @map.grid[ right_bot(cl) ]]
		else 
			[:rb, 99999999999]
		end			
	end	

	# returns true if the rightermost column has been reached. false otherwise.
	def at_right_side?(cl)
		cl[1] == @map.nr_columns
	end

end