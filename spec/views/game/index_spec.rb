require 'spec_helper'

describe "game/index.html.erb" do
  before(:each) do
    render
  end

  it "shows the knocked pins form with input" do
    rendered.should have_xpath('//form[@method="post"]/div[@id="knocked_pins"]/div[@id="block-ball1"]/input[@name="ball1"]')
  end

  it "doesn't show the result table" do
    rendered.should_not have_xpath('//table[@id="results"]')
  end

end
