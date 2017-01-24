class GengoController < ApplicationController
  # GET /gengo/random(/limit/:limit(/excepts/*excepts))
  def random
    @gengo = Gengo.find_random(
      limit: params[:limit],
      excepts: extract_ids(params[:excepts])
    )
    render json: @gengo
  end

  private
  def extract_ids(excepts)
    excepts.is_a?(String) ? excepts.split('/') : excepts
  end
end
