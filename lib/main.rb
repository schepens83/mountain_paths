# require "ruby-prof"
# require_relative "Profiler"
require_relative "map"
require_relative "image_drawer"
require_relative "route"
require_relative "route_evaluator"


# map = Map.new(path: "./data/Colorado_480x480.dat")
# map = Map.new(path: "./data/etopo1_bedrock.asc")
map = Map.new(path: "./data/us-west-coast", height: 480, width: 800)
# map = Map.new(path: "./data/testMountains.dat")
# map = Map.new(path: "./spec/map_spec_data")

def draw_all_routes_and_best(map)
	id = ImageDrawer.new(map: map)
	id.draw_map

	re = RouteEvaluator.new(map: map)
	re.create_all_routes
	
	id.draw_routes(re.routes)

	id.draw_route(re.best_route, RgbColor.new(r: 34, g: 139, b: 34))

	id.save_image("img/img_#{1.to_s.rjust(4, "0")}.png")
end

def draw_route_per_pixel(map)
	routes = Array.new
	id = ImageDrawer.new(map: map)
	id.draw_map

	route = Route.new(map: map, init_loc: [10,1])

	i = 1
	id.draw_route_per_step(route) do 
		id.save_image("img/img_#{i.to_s.rjust(4, "0")}.png")
		i += 1
		print "#{i.to_s.rjust(4, "0")}\r"
	end
end

def draw_all_routes_per_col(map)
	id = ImageDrawer.new(map: map)
	id.draw_map

	re = RouteEvaluator.new(map: map)
	re.create_all_routes
	
	i = 1
	id.draw_routes_per_column(re.routes) do
		id.save_image("img/img_#{i.to_s.rjust(4, "0")}.png")		
		i += 1
		print "#{i.to_s.rjust(4, "0")}\r"
	end
end

# Profiler::profile do
	# draw_route_per_pixel(map)
	# draw_all_routes_and_best(map)
	draw_all_routes_per_col(map)
# end