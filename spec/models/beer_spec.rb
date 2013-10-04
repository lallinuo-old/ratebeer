require 'spec_helper'

describe Beer do
  it "is not saved without name" do
    beer = Beer.create :name=>""
    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

  it "is not saved without style" do
    beer = Beer.create :name=>"jou"
    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end
end
