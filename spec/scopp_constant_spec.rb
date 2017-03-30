require "rails_helper"
require "active_attr/rspec"

RSpec.describe ScoppConstant, :type => :model do
  it "orders by last name" do
    expect(ScoppConstant.get_url(500)).to eq("http://api.syosetu.com/novelapi/api/?out=json&lim=500&start=500&gzip=5")
  end
end