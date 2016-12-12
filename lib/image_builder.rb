require 'chunky_png'

# Creates the png image of the map
class ImageBuilder

	def initialize(map)
		@map = map
		@image = ChunkyPNG::Image.new(@map.nr_columns, @map.nr_rows, ChunkyPNG::Color::TRANSPARENT)

	end


	def draw_map
		@map.nr_rows.times do |row|
			@map.nr_columns.times do |col|
				teint = (normalize( @map.min_height, @map.max_height, @map.grid[[ row + 1,col + 1 ]].to_f ) * 255).to_i
				# chunckyPNG uses x,y coordinates, instead of the y,x coordinates in this program
				@image[ col,row ] = ChunkyPNG::Color.grayscale(teint)
				((teint.to_f / 255) * 100).to_i
			end
		end
	end

	def draw_route(route)
		if block_given?  
			
			route.each do |e|  
				col = e[1]
				row = e[0]
				@image[ col - 1,row - 1 ] = ChunkyPNG::Color.rgba(255, 0, 0, 128)
				
				yield
			end
			
		else  

			route.each do |e|  
				col = e[1]
				row = e[0]
				@image[ col - 1,row - 1 ] = ChunkyPNG::Color.rgba(255, 0, 0, 128)
			end

		end  
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