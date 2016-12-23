require 'chunky_png'

# Representation of a color
class RgbColor
	attr_reader :r, :g, :b

	def initialize(args)
		@r = args[:r] || 255
		@g = args[:g] || 0
		@b = args[:b] || 0
	end  

end

# Creates the png image of the map
class ImageDrawer
	attr_reader :from_color, :to_color, :map
	COLOR = RgbColor.new(r: 255, g: 0, b: 0)

	def initialize(args)
		@map = args[:map]; raise "No map argument (map is nil)" if @map == nil
		@image = ChunkyPNG::Image.new(@map.nr_columns, @map.nr_rows, ChunkyPNG::Color::TRANSPARENT)
		@from_color = args[:from_color] || nil
		@to_color = args[:to_color] || nil
	end

	# draw the map on @image.
	def draw_map
		@map.nr_rows.times do |row|
			@map.nr_columns.times do |col|
				teint = (normalize( @map.min_height, @map.max_height, @map.grid[[ row + 1,col + 1 ]].to_f ) * 255).to_i

				# chunckyPNG uses x,y coordinates, instead of the y,x coordinates in this program -> [ col, row ]
				if from_color == nil || to_color == nil
					draw_greyscale_pixel(col,row, teint)
				else
					draw_color_interpolated_pixel(col, row, teint)
				end
			end
		end
	end

	# draws all the routes on @image column by column. Yields after every column
	def draw_routes_per_column(routes, color = COLOR)
		(1..map.nr_columns).to_a.each do |col|  
			routes.each do |route| 
				route.route.each do |step|  
					draw_step(step) if step[1] == col
				end
			end
			yield
		end
	end

	# draws all the routes on @image
	def draw_routes(routes, color = COLOR)
		routes.each { |r| draw_route(r, color) }
	end
	
	# draw a route on @map, but yields after each pixel is drawn. e.g. to save the image
	def draw_route_per_step(route, color = COLOR)
		route.route.each do |step|   
			draw_step(step, color)
			yield
		end
	end

	# draw the route on @image.
	def draw_route(route, color = COLOR)
		route.route.each do |step|  
			draw_step(step, color)			
		end
	end

	# save the image to filename location.
	def save_image(filename)
		@image.save(filename, :interlace => true)		
	end


	private

	# draw an individual step of a route on the map
	def draw_step(step, color = COLOR)
		col = step[1]
		row = step[0]
		@image[ col-1 , row-1 ] = ChunkyPNG::Color.rgba(color.r, color.g, color.b, 128)		
	end

	# normalize value between 0 and 1
	def normalize(min, max, val)
		(val - min) / (max - min)
	end

	# draw an individual pixel of the map in greyscale
	def draw_greyscale_pixel(col,row, teint)
		@image[ col,row ] = ChunkyPNG::Color.grayscale(teint)		
	end

	# draw an individual pixel of the map in interpreted color (between 2 colors)
	def draw_color_interpolated_pixel(col,row, teint)
		@image[ col,row ] = ChunkyPNG::Color.interpolate_quick(from_color, to_color, teint)
	end
end