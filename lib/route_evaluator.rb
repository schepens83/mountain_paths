class RouteEvaluator
	attr_reader :map, :routes

	def initialize(args)
		@map = args[:map]
		@routes = Array.new
	end

	def create_all_routes
		(1..map.nr_columns).step(1).to_a.each do |e|  
			route = Route.new(map: map, init_loc: [e,1])
			@routes << route
		end
	end

	def best_route
		routes.min_by { |route| route.tot_elavation }
	end
end