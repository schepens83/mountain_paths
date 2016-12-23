# Chooses the optimal route on the map, from left to right.
class Route
	attr_reader :route, :tot_elavation, :init_loc, :cl

	def initialize(args)
		args = defaults.merge(args)

		@map = args[:map]; raise "No map argument (map is nil)" if @map == nil
		@route = Array.new
		@init_loc = args[:init_loc]
		@tot_elavation = 0
		calculate_route
	end

	def defaults
		{ init_loc: [1,1] }
	end


	private

	# create the route from left to right. coordinates in [y, x] format. map starts left top.
	def calculate_route
		@cl = init_loc
		@route << cl

		while not at_rightmost_side?
			@cl = next_step
			@route << cl
		end 		
	end

	# returns right top coordinates
	def right_top
		[ cl[0]-1, cl[1]+1 ]
	end

	# returns right mid coordinates
	def right_mid
		[ cl[0], cl[1]+1 ] 
	end

	# returns right bottom coordinates
	def right_bot
		[ cl[0]+1, cl[1]+1 ]
	end	

	# return the coordinates of the optimal next step 
	def next_step
		# choose the next step based on the lowest absolute delta
		next_step = [ delta_right_top, delta_right_mid, delta_right_bot ].min_by { |i| i[1].abs }

		# increase tot_elavation with the delta between current and next step
		@tot_elavation += next_step[1].abs

		return next_step[0]
	end

	# calculates the delta between current location (cl) and it's right top location. cl is the current location
	def delta_right_top
		if cl[0] > 1 
			[right_top, @map.grid[cl] - @map.grid[ right_top ]]
		else
			# give a very large number that will never be chosen
			[right_top, 99999999999]
		end
	end

	# calculates the delta between current location (cl) and it's right mid location
	def delta_right_mid
		# cl is the current location
		[right_mid, @map.grid[cl] - @map.grid[ right_mid ]]
	end

	# calculates the delta between current location (cl) and it's right bottom location
	def delta_right_bot
		if cl[0] < @map.nr_rows 
			# give a very large number that will never be chosen
			[right_bot, @map.grid[cl] - @map.grid[ right_bot ]]
		else 
			[right_bot, 99999999999]
		end			
	end	

	# returns true if the rightermost column has been reached. false otherwise.
	def at_rightmost_side?
		cl[1] == @map.nr_columns
	end

end