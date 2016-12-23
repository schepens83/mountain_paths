require_relative "map"
require_relative "image_drawer"
require_relative "route"
require "ruby-prof"
require_relative "Profiler"

map = Map.new
map.read_file("./data/Colorado_480x480.dat")
# map.read_file("./data/testMountains.dat")
# map.read_file("./spec/map_spec_data")

def draw_all_routes_and_best(map)
	routes = Array.new
	id = ImageDrawer.new(map: map)
	id.draw_map

	(1..480).step(2).to_a.each do |e|  
		route = Route.new(map: map, init_loc: [e,1])
		routes << route
	end

	best_route = routes.min_by { |route| route.tot_elavation }

	# route_reps = Array.new
	# routes.each do |route|
	# 	route_reps << route.route
	# end
	# id.draw_routes(route_reps)
	id.draw_routes(routes)

	id.draw_route(best_route, RgbColor.new(r: 34, g: 139, b: 34))

	id.save_image("img/Colorado_#{1.to_s.rjust(4, "0")}.png")

end

def draw_route_per_pixel(map)
	routes = Array.new
	id = ImageDrawer.new(map: map)
	id.draw_map

	route = Route.new(map: map, init_loc: [10,1])

	i = 1
	id.draw_route_per_step(route) do 
		id.save_image("img/Colorado_#{i.to_s.rjust(4, "0")}.png")
		i += 1
		print "#{i.to_s.rjust(4, "0")}\r"
	end

end

# draw_route_per_pixel(map)



Profiler::profile do
	draw_all_routes_and_best(map)
end
