require "map"

describe Map do
	describe ".add" do
    context "given an empty string" do
      it "returns zero" do
        expect(Map.new.add("")).to eql(0)
      end
    end
  end
end