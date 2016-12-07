require 'chunky_png'

a = Hash.new

n = 1
m = 1

File.open("./Colorado_480x480.dat", "r") do |f|
  f.each_line do |line|
    line.split(" ").map { |s| s.to_i }.each do |val|
    	a[[n,m]] = val
    	m = m + 1
    end
    n = n + 1
    m = 1
  end
end



p max_val = a.max_by{|k,v| v}[1].to_f
p min_val = a.min_by{|k,v| v}[1].to_f

# normalize value between 0 and 1
def normalize(min, max, val)
	(val - min) / (max - min)
end

# Creating an image from scratch, save as an interlaced PNG
png = ChunkyPNG::Image.new(480, 480, ChunkyPNG::Color::TRANSPARENT)

480.times do |n|
	480.times do |m|
		teint = normalize( min_val, max_val, a[[n+1,m+1]].to_f ) * 255
		png[n,m] = ChunkyPNG::Color.grayscale(teint.to_i)
		# png[n,m] = ChunkyPNG::Color.rgba(n*10, m*10, 30, 128)
	end
end
# png[1,1] = ChunkyPNG::Color.rgba(200, 20, 30, 128)
# png[2,1] = ChunkyPNG::Color('black @ 0.5')
png.save('filename.png', :interlace => true)

