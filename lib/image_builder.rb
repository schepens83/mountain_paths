require 'chunky_png'
require_relative "map"

# Creates the png image of the map
class ImageBuilder
	# attr_reader :map

	def initialize(map)
		# Creating an image from scratch, save as an interlaced PNG
		
		@map = map
		@image = ChunkyPNG::Image.new(@map.nr_columns, @map.nr_rows, ChunkyPNG::Color::TRANSPARENT)

	end


	def build_image
		@map.nr_columns.times do |col|
			@map.nr_rows.times do |row|
				teint = normalize( @map.min_height, @map.max_height, @map.grid[[ col+1,row+1 ]].to_f ) * 255 
				@image[ col,row ] = ChunkyPNG::Color.grayscale(teint.to_i)
			end
		end
		p @image
	end

	def save_image(filename)
		@image.save(filename, :interlace => true)		
	end


	private

	# normalize value between 0 and 1
	def normalize(min, max, val)
		(val - min) / (max - min)
	end

	

end

mp = Map.new
mp.read_file("./spec/map_spec_data")
ib = ImageBuilder.new(mp)
ib.build_image
ib.save_image("test.png")
