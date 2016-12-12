require_relative "map"
require_relative "image_builder"
require_relative "route_picker"

mp = Map.new
# mp.read_file("./data/Colorado_480x480.dat")
mp.read_file("./data/testMountains.dat")
# mp.read_file("./spec/map_spec_data")


	rp = RoutePicker.new(mp, [2,1])


# ib = ImageBuilder.new(mp)
# ib.build_image
# ib.save_image("img/test.png")



