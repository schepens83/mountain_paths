require_relative "map"
require_relative "image_drawer"
require_relative "route_picker"


map = Map.new
map.read_file("./data/Colorado_480x480.dat")
# map.read_file("./data/testMountains.dat")
# map.read_file("./spec/map_spec_data")

def draw_all_routes_and_best(map)
	route_pickers = Array.new
	id = ImageDrawer.new(map: map)
	id.draw_map

	(1..480).step(2).to_a.each do |e|  
		rp = RoutePicker.new(map: map, init_loc: [e,1])
		rp.calculate_route
		route_pickers << rp
	end

	best_route = route_pickers.min_by { |rp| rp.tot_elavation }

	route_pickers.each do |rp|
		id.draw_route(rp.route)
	end

	id.draw_route(best_route.route, RgbColor.new(r: 34, g: 139, b: 34))

	id.save_image("img/Colorado_#{1.to_s.rjust(4, "0")}.png")

end

def draw_route_per_pixel(map)
	route_pickers = Array.new
	id = ImageDrawer.new(map: map)
	id.draw_map

	rp = RoutePicker.new(map: map, init_loc: [10,1])
	rp.calculate_route
	route = rp.route

	i = 1
	id.draw_route_per_each_pixel(route) do 
		id.save_image("img/Colorado_#{i.to_s.rjust(4, "0")}.png")
		i += 1
		print "#{i.to_s.rjust(4, "0")}\r"
	end

end

# draw_route_per_pixel(map)
draw_all_routes_and_best(map)

