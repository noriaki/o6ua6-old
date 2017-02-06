class WelcomeController < ApplicationController
  def index
    @gengos = Gengo.limit(2).random
    gon.gengos = @gengos.map { |g| GengoSerializer.new(g).to_h }
  end
end
