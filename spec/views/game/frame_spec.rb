require 'spec_helper'

describe "game/frame.html.erb" do
  before(:each) do
    @game = Game.new({ball1: 0, ball2: 0}, nil)
    render
  end

  it "shows the result table" do
    rendered.should have_xpath('//table[@id="results"]')
  end

  it "shows a form" do
    rendered.should have_xpath('//form[@method="post"]/div[@id="knocked_pins"]')
  end

end
