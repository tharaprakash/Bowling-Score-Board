require 'spec_helper'

describe GameController do


  describe "#new" do
    before(:each) do
      get :new
    end

    it "redirects to a new game" do
      response.should redirect_to('/game')
    end

    it "resets the frames of the previous game" do
      session[:frame].should be_nil
    end
  end

  describe "#index" do
    it "renders index template" do
      get :index
      response.should render_template("game/index")
    end
  end

  describe "#frame" do
    let(:game) do
      game = double('Game')
      Game.stub(:new).and_return(game)
      game
    end

    it "makes calculation when data are valid" do
      game.should_receive(:valid?).and_return(true)
      game.should_receive(:calc).and_return(true)
      game.should_receive(:over?).and_return(true)
      post :frame
    end

    it "flashes an error message when data are not valid" do
      game.should_receive(:valid?).and_return(false)
      game.should_receive(:error_message).and_return('Error')
      game.should_receive(:over?).and_return(true)
      post :frame
      flash[:error].should eq('Error')
    end
  end

end
