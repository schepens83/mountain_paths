require_relative "map"
require_relative "image_builder"
require_relative "route_picker"
# require 'streamio-ffmpeg'

map = Map.new
map.read_file("./data/Colorado_480x480.dat")
# map.read_file("./data/testMountains.dat")
# map.read_file("./spec/map_spec_data")


route_pickers = Array.new
ib = ImageBuilder.new(map)
ib.draw_map

for e in (479).downto(1)
# (1..480).step(15).to_a.each do |e|  
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

route_pickers.each { |rp| puts rp.tot_elavation }
p best_route = route_pickers.min_by { |rp| rp.tot_elavation }
p best_route.tot_elavation


route_pickers.each do |rp|
	ib.draw_route(rp.route)
end

ib.draw_route(best_route.route, RgbColor.new(34,139,34))

ib.save_image("img/Colorado_#{1.to_s.rjust(4, "0")}.png")

# slideshow_transcoder = FFMPEG::Transcoder.new(
#   '',
#   'slideshow.mp4',
#   { resolution: "480x480" },
#   input: 'img/Colorado_%03d.jpeg',
#   input_options: { framerate: '1/5' }
# )

# slideshow = slideshow_transcoder.run