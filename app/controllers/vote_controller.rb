class VoteController < ApplicationController
  # POST /vote
  def perform
    winner_id, loser_id = extract_ids(params[:data])
    add_history_to_session([winner_id, loser_id])
    @winner = Gengo.where(identifier: winner_id).first
    @loser = Gengo.where(identifier: loser_id).first
    if @winner.won(@loser) && Vote.apply(session[:uid], @winner, @loser)
      head :created # , location: gengo_path(@winner) # TODO
    else
      head :bad_request
    end
  end

  private

  def add_history_to_session(excepts)
    session[:history] ||= []
    session[:history] << excepts
  end
end
