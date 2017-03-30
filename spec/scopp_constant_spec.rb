require "rails_helper"
require "active_attr/rspec"

RSpec.describe ScoppConstant, :type => :model do
  it "get_url" do
    expect(ScoppConstant.get_url(500)).to eq("http://api.syosetu.com/novelapi/api/?out=json&lim=500&start=500&gzip=5")
  end
  
  it "push note"do
    title="title title"
    body="body asiegarga"
    push=ScoppConstant.pushbullet_note(title,body)
    expect(push.body["active"]).to eq(true)
    expect(push.body["type"]).to eq("note")
    expect(push.body["title"]).to eq(title)
    expect(push.body["body"]).to eq(body)
  end
end