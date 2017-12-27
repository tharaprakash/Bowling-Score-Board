require 'spec_helper'

describe Game do

  describe "validation" do
    it "checks that the number of knocked pins by the 1st ball is in range" do
      params = {ball1: 11, ball2: 0}
      game = Game.new(params, nil)
      game.valid?.should be_nil
      game.error_message.should == 'The 1st ball knocked wrong number of pins'
    end

    it "checks that the number of knocked pins by the 2nd ball is in range" do
      params = {ball1: 0, ball2: 15}
      game = Game.new(params, nil)
      game.valid?.should be_nil
      game.error_message.should == 'The 2nd ball knocked wrong number of pins'
    end

    it "checks that the number of knocked pins by the 1st and the 2nd ball is in range" do
      params = {ball1: 7, ball2: 6}
      game = Game.new(params, nil)
      game.valid?.should be_nil
      game.error_message.should == 'The sum of knocked pins is wrong'
    end

    it "checks if it's a strike" do
      params = {ball1: 10, ball2: 0}
      game = Game.new(params, nil)
      game.strike?.should be_true
      params = {ball1: 5, ball2: 5}
      game = Game.new(params, nil)
      game.strike?.should be_false
    end

    it "checks if it's a spare" do
      params = {ball1: 5, ball2: 5}
      game = Game.new(params, nil)
      game.spare?.should be_true
      params = {ball1: 4, ball2: 5}
      game = Game.new(params, nil)
      game.spare?.should be_false
    end

    it "calcs strikes properly" do
      frames = [{spare: false, strike: true, score: 10}]
      params = {ball1: 1, ball2: 2}
      game = Game.new(params, frames)
      game.calc
      game.total.should == 16
    end

    it "calcs spares properly" do
      frames = [{spare: true, strike: false, score: 10}]
      params = {ball1: 1, ball2: 2}
      game = Game.new(params, frames)
      game.calc
      game.total.should == 14
    end

    it "finish the game after the last frame" do
      params = {ball1: 1, ball2: 2}
      game = Game.new(params, nil)
      game.stub(:frame_number).and_return(10)
      game.over?.should be_true
    end

    it "calcs the total score" do
      frames = [{score: 5}, {score: 4}, {score: 9}, {score: 10}, {score: 2}, {score: 1}]
      game = Game.new({}, frames)
      game.total.should == 31
    end
  end

end
