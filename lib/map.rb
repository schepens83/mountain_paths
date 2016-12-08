# Representation of the map that needs to be traversed.
class Map
	attr_reader :grid

	def initialize()
		@grid = Hash.new
	end

	def read_file(path)
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

	private

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
		str.split(" ").all? { |val| val !~ /\D/ }
	end

	def spaces_between_values?(str)
		str.split(" ").length > 1
	end
end

# "./Colorado_480x480.dat"