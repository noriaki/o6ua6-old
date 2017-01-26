class GengoController < ApplicationController
  # GET /gengo/random(/limit/:limit(/excepts/*excepts))
  def random
    @gengo = Gengo.find_random(
      limit: params[:limit],
      excepts: extract_ids(params[:excepts])
    )
    render json: @gengo
  end
end
