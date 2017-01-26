class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception

  protected
  def extract_ids(excepts)
    excepts.is_a?(String) ? excepts.split('/') : excepts
  end
end
