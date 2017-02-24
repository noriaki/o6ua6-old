class WelcomeController < ApplicationController
  def index
    @gengos = Gengo.limit(2).random
    gon.gengos = serialize(@gengos)
    gon.history = build_history
  end

  private

  def serialize(gengos)
    gengos.map { |gengo| GengoSerializer.new(gengo).to_h }
  end

  def history
    session[:history] || []
  end

  def build_history
    hists = Gengo.in(identifier: history.flatten.uniq).to_a
    history.map do |ids|
      serialize(ids.map { |id| hists.find { |g| g.identifier == id } })
    end
  end
end
