class WelcomeController < ApplicationController
  def index
    @gengos = Gengo.limit(2).random
    gon.gengos = @gengos.map { |g| GengoSerializer.new(g) }
  end
end
