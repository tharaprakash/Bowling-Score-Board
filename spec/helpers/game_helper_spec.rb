require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the GameHelper. For example:
#
# describe GameHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe GameHelper do
  before(:each) do
    @game = double('Game')
  end

  describe "#score_cells" do
    it "prints current score in table cells" do
      frame = [{score: 1}, {score: 2}, {score: 3}]
      @game.stub(:frame).and_return(frame)
      helper.score_cells.should == '<td>1</td><td>2</td><td>3</td>'
    end
  end

  describe "#header_cells" do
    it "prints header cells based on a frame number" do
      @game.stub(:frame_number).and_return(3)
      helper.header_cells.should == '<td>#1</td><td>#2</td><td>#3</td>'
    end
  end

end
