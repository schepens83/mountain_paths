require_relative "map"
require_relative "image_builder"
require_relative "route_picker"
# require 'streamio-ffmpeg'

map = Map.new
map.read_file("./data/Colorado_480x480.dat")
# map.read_file("./data/testMountains.dat")
# map.read_file("./spec/map_spec_data")

def draw_all_routes_and_best(map)
	route_pickers = Array.new
	ib = ImageBuilder.new(map)
	ib.draw_map

	(1..480).step(2).to_a.each do |e|  
		rp = RoutePicker.new(map, [e,1])
		rp.calculate_route
		route_pickers << rp

	# i = 1
	# ib.draw_route_per_each_pixel(route) do 
	# 	ib.save_image("img/Colorado_#{i.to_s.rjust(4, "0")}.png")
	# 	i += 1
	# 	print "#{i.to_s.rjust(4, "0")}\r"
	# end
	end

	best_route = route_pickers.min_by { |rp| rp.tot_elavation }

	route_pickers.each do |rp|
		ib.draw_route(rp.route)
	end

	ib.draw_route(best_route.route, RgbColor.new(34,139,34))

	ib.save_image("img/Colorado_#{1.to_s.rjust(4, "0")}.png")

end

def draw_route_per_pixel(map)
	route_pickers = Array.new
	ib = ImageBuilder.new(map)
	ib.draw_map

	rp = RoutePicker.new(map, [10,1])
	rp.calculate_route
	route = rp.route

	i = 1
	ib.draw_route_per_each_pixel(route) do 
		ib.save_image("img/Colorado_#{i.to_s.rjust(4, "0")}.png")
		i += 1
		print "#{i.to_s.rjust(4, "0")}\r"
	end

end

draw_route_per_pixel(map)

