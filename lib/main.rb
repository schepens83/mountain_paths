require_relative "map"
require_relative "image_builder"
require_relative "route_picker"

map = Map.new
map.read_file("./data/Colorado_480x480.dat")
# map.read_file("./data/testMountains.dat")
# map.read_file("./spec/map_spec_data")

route = Array.new
# (1..480).step(15).to_a.each do |e|  
	rp = RoutePicker.new(map, [200,1])
	route = rp.calculate_route

	ib = ImageBuilder.new(map)
	ib.draw_map
	e = 1
	ib.draw_route(route) do 
		ib.save_image("img/Colorado_#{e.to_s.rjust(4, "0")}.png")
		e = e + 1
	end

# end