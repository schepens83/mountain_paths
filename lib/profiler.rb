module Profiler
	def self.profile
    # Profile the code
    RubyProf.start

    yield

    results = RubyProf.stop


    root = "/users/sanderschepens/Applications/ruby/mountain_paths"


    File.open "#{root}/tmp/profile-graph.html", 'w' do |file|
    	RubyProf::GraphHtmlPrinter.new(results).print(file)
    end

    File.open "#{root}/tmp/profile-flat.txt", 'w' do |file|
    	RubyProf::FlatPrinter.new(results).print(file)
    end

    File.open "#{root}/tmp/profile-tree.prof", 'w' do |file|
    	RubyProf::CallTreePrinter.new(results).print(file)
    end
  end
end 