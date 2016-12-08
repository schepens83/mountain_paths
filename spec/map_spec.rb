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
end