# Representation of the map that needs to be traversed.
class Map
	attr_reader :grid, :width, :height, :path

	# coordinates in [y, x] format. map starts left top.
	def initialize(args)
		@grid = Hash.new
		@path = args[:path] 
		raise "no path given!" if path == nil 
		read_file

		@width = args[:width] || nr_columns
		@height = args[:height] || nr_rows
		redimension_map! if !original_width_and_height?
	end

	def nr_rows
		@nr_rows ||= grid.max_by { |k,v| k[0] }[0][0].to_i
	end

	def nr_columns
		@nr_columns ||= grid.max_by { |k,v| k[1] }[0][1].to_i
	end

	def max_height
		@max_height ||= grid.max_by{|k,v| v}[1].to_f		
	end

	def min_height
		@min_height ||= grid.min_by{|k,v| v}[1].to_f		
	end

	private

	def read_file
		n = 1
		m = 1
		if correct_file?(path)
			
			File.open(path, "r") do |f|
				f.each_line do |line|
					line.split(" ").map { |s| s.to_i }.each do |val|
						@grid[[n,m]] = val
						m = m + 1
					end
					n = n + 1
					m = 1
				end
			end

			return true
		else
			return false
		end
	end

	def correct_file?(path)
		correct = true

		File.open(path, "r") do |f|
			f.each_line do |line|
				unless spaces_between_values?(line) && only_numbers?(line)
					correct = false
				end
			end
		end

		return correct
	end

	def only_numbers?(str)
		str.split(" ").all? { |val| val =~ /-{0,1}\d/ }
	end

	def spaces_between_values?(str)
		str.split(" ").length > 1
	end

	# redimensions the map that was given to it. Height will be evaluated from top to bottom and width from left to right.
	def redimension_map!
		@grid.select! { |coordinate| coordinate[0] <= height && coordinate[1] <= width }
		# reset columns and rows
		@nr_columns = grid.max_by { |k,v| k[1] }[0][1].to_i
		@nr_rows = grid.max_by { |k,v| k[0] }[0][0].to_i	
	end

	def original_width_and_height?
		(width == nr_columns) && (height == nr_rows)
	end
end