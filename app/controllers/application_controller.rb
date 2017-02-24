class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  before_action :set_uid_to_session

  protected

  def extract_ids(excepts)
    excepts.is_a?(String) ? excepts.split('/') : excepts
  end

  private

  def set_uid_to_session
    session[:uid] ||= generate_uid
  end

  def generate_uid
    SecureRandom.base64(4).delete('=').tr('+/', '-_')
  end
end
