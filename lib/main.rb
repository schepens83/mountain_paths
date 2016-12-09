require_relative "map"
require_relative "image_builder"

mp = Map.new
mp.read_file("./data/Colorado_480x480.dat")
# mp.read_file("./spec/map_spec_data")
ib = ImageBuilder.new(mp)
ib.build_image
ib.save_image("img/test.png")



