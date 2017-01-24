class GengoController < ApplicationController
  def random
    render json: Gengo.find_random(
             limit: params[:limit],
             excepts: extract_ids(params[:excepts]))
  end

  private
  def extract_ids(excepts)
    excepts.is_a?(String) ? excepts.split('/') : excepts
  end
end
