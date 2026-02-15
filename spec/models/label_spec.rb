require 'rails_helper'

RSpec.describe Label, type: :model do
  describe "validation" do
    context "when name is empty" do
      it "is invalid" do
        expect(Label.new().valid?).to be false
        expect(Label.new(name: "    ").valid?).to be false
      end
    end

    context "when name is present" do
      it "is valid" do
        expect(Label.new(name: "Vegetarian").valid?).to be true
      end
    end
  end
end
