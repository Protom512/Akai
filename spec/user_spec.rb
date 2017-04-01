require "rails_helper"

RSpec.describe Novel, :type => :model do
    data={"userid"=>"22","writer"=>"john"}
    it "set_data" do
        User.set_data(data)
        expect(User.find(22).writer).to eq("john")
    end
end