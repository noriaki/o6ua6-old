class WelcomeController < ApplicationController
  def index
    @kanji = Kanji.random.first
  end
end
