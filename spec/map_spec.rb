require "map"

describe Map do
	describe ".read_file" do
		context "given correct file" do
			it "returns true" do
				map = Map.new
				expect(map.read_file("./spec/map_spec_data")).to be true
      end

			it "returns the correct value for a grid location" do
				map = Map.new
				map.read_file("./spec/map_spec_data")
				expect(map.grid[[1,1]]).to eql(1)
      end

    end

		context "given incorrect file" do
			it "returns false" do
				map = Map.new
				expect(map.read_file("./spec/map_spec_data_incorrect")).to be false
      end

		end
  end

	describe ".nr_rows" do
		before do 
			@map = Map.new
			@map.read_file("./spec/map_spec_data")
		end

		it "returns the correct number of rows" do
			expect(@map.nr_rows).to eql 2
		end
	end

	describe ".nr_columns" do
		before do 
			@map = Map.new
			@map.read_file("./spec/map_spec_data")
		end

		it "returns the correct number of columns" do
			expect(@map.nr_columns).to eql 3
		end
	end

	describe ".max_height" do
		before do 
			@map = Map.new
			@map.read_file("./spec/map_spec_data")
		end

		it "returns the max height" do
			expect(@map.max_height).to eql 6.0
		end
	end

	describe ".nr_columns" do
		before do 
			@map = Map.new
			@map.read_file("./spec/map_spec_data")
		end

		it "returns the minimum height" do
			expect(@map.min_height).to eql 1.0
		end
	end

end