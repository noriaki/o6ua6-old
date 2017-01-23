class WelcomeController < ApplicationController
  def index
    @gengo = Gengo.random.first
  end
end
