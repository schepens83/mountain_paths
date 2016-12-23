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
	COLOR = RgbColor.new(r: 255, g: 0, b: 0)

	def initialize(args)
		@map = args[:map]; raise "No map argument (map is nil)" if @map == nil
		@image = ChunkyPNG::Image.new(@map.nr_columns, @map.nr_rows, ChunkyPNG::Color::TRANSPARENT)
	end

	# draw the map on @image.
	def draw_map
		@map.nr_rows.times do |row|
			@map.nr_columns.times do |col|
				teint = (normalize( @map.min_height, @map.max_height, @map.grid[[ row + 1,col + 1 ]].to_f ) * 255).to_i

				# chunckyPNG uses x,y coordinates, instead of the y,x coordinates in this program -> [ col, row ]
				color1 = ChunkyPNG::Color.rgb(255, 255, 255) #white
				color2 = ChunkyPNG::Color.rgb(0, 0, 0) #black
				@image[ col,row ] = ChunkyPNG::Color.interpolate_quick(color1,color2 , teint)

			end
		end
	end

	# yield after each pixel is drawn. e.g. to save the image
	def draw_route_per_each_pixel(route, color = COLOR)
		route.length.times do
			pixel = route.shift
			draw_route([pixel], color)
			yield
		end
	end

	# draws all the routes that are given to it.
	def draw_routes(routes, color = COLOR)
		routes.each { |r| draw_route(r, color) }
	end

	# draw the route on @image.
	def draw_route(route, color = COLOR)
		route.each do |e|  
			col = e[1]
			row = e[0]
			@image[ col-1 , row-1 ] = ChunkyPNG::Color.rgba(color.r, color.g, color.b, 128)
		end
	end

	# save the image to filename location.
	def save_image(filename)
		@image.save(filename, :interlace => true)		
	end


	private

	# normalize value between 0 and 1
	def normalize(min, max, val)
		(val - min) / (max - min)
	end

end

